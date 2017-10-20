FROM node:8

RUN npm install localtunnel@1.8.3

COPY patch patch
RUN patch -p1 node_modules/localtunnel/lib/TunnelCluster.js < patch/tunnel-cluster.patch \
    &&  patch -p1 node_modules/localtunnel/bin/client < patch/client.patch \
    &&  patch -p1 node_modules/localtunnel/lib/Tunnel.js < patch/tunnel.patch

ENTRYPOINT [ "./node_modules/.bin/lt" ]

