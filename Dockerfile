# BUILD-USING:        docker build -t nerve-registry .
# RUN-USING:          docker run --rm -t -i --name nerve synapse
FROM        quay.io/queue/base-ruby 

# add the application and bundle
ADD . /app
RUN bundle --gemfile=/app/Gemfile

ENV           SYNAPSE_CONFIG      /app/config/conf.json
VOLUME        ["/haproxy"]
CMD           ["/app/bin/synapse"]

