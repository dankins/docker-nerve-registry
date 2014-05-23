# BUILD-USING:        docker build -t nerve-registry .
# RUN-USING:          docker run --rm -t -i --name nerve synapse
FROM        quay.io/queue/base-ruby 

# add the application and bundle
ADD . /app
RUN chown -R daemon /app
#USER daemon
WORKDIR /app
RUN bundle install --deployment

ENV           NERVE_CONFIG      /app/config/config.json
CMD           ["bundle", "exec","/app/bin/nerve_registry.rb"]
