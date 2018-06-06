FROM node:8

VOLUME /data
ENV DATA_PATH /data
ENV FORWARD_HOST docker.for.mac.localhost
EXPOSE 443

RUN npm install --save --ignore-scripts 'nassau-https-proxy@~1.0.2'

CMD node_modules/.bin/nassau-https-proxy

