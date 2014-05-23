# BUILD-USING:        docker build -t nerve-registry .
# PUSH-USING:         docker tag nerve-registry quay.io/queue/nerve-registry  && docker push quay.io/queue/nerve-registry
FROM        quay.io/queue/base-ruby 

# add the application and bundle
ADD . /app
WORKDIR /app
RUN bundle install --deployment

ENV           NERVE_CONFIG      /app/config.json
CMD           ["/app/run.sh"]
