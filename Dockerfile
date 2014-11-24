FROM scratch
ADD etcd /usr/sbin/etcd

ENTRYPOINT ["/usr/sbin/etcd"]
ENV ETCD_DATA_DIR /srv/etcd/var
ENV ETCD_LISTEN_CLIENT_URLS http://0.0.0.0:2379,http://0.0.0.0:4001
ENV ETCD_LISTEN_PEER_URLS http://0.0.0.0:2380,http://0.0.0.0:7001
EXPOSE 4001 7001 2379 2380
VOLUME ["/srv/etcd"]
