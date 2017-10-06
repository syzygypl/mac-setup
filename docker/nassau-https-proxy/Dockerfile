FROM node:6

VOLUME /data/.nassau-proxy
ENV HOME /data
ENV FORWARD_HOST docker.for.mac.localhost
EXPOSE 443

RUN npm install --save --ignore-scripts nassau-https-proxy

CMD node_modules/.bin/nassau-https-proxy

