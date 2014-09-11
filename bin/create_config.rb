#!/usr/bin/env ruby
require "net/http"
require "uri"
require 'yaml'
require 'optparse'

require 'json'

DOCKER_HOST = ENV['DOCKER_HOST']
DOCKER_PORT = ENV['DOCKER_PORT'] || 4243
CONTAINER = ENV['APP_NAME']
SERVICE = ENV['SERVICE']
ETCD_HOST = DOCKER_HOST
ETCD_PORT = 4001

FILE_LOCATION="/app/config.json"

def getContainerDetails()
  uri = URI.parse("http://#{DOCKER_HOST}:#{DOCKER_PORT}/containers/json")
  response = Net::HTTP.get_response(uri)
  resultArr = JSON.parse response.body
  resultArr.map { |x| 
    if x["Names"].include? CONTAINER
      x
    else
      nil
    end 
  }.reject{|i| i.nil? || i.empty? }
  .first
end

def generateConfig(containerJson)
  ports = containerJson["Ports"]
  {
    "instance_id" => "nerve",
    "services" => {
      SERVICE => {
	"host" => DOCKER_HOST,
        "port" => ports.first["PublicPort"],
        "reporter_type" => "etcd",
        "etcd_host" => ETCD_HOST,
        "etcd_port" => ETCD_PORT,
        "etcd_path" => "/nerve/services/#{SERVICE}/services",
        "check_interval" => 2,
        "checks" => [
          {
          "type"=> "http",
          "uri"=> "/health",
          "timeout"=> 0.2,
          "rise"=> 3,
          "fall"=> 2
          }
        ]
      } 
    }
  }.to_json
end

config =  generateConfig(getContainerDetails())
puts "Generated config: \n #{config} \n"
File.open(FILE_LOCATION, 'w') { |file| file.write(config) }

puts "Config file successfuly written to #{FILE_LOCATION}"
