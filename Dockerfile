FROM scratch
ADD etcd /usr/sbin/etcd
EXPOSE 4001 7001
ENTRYPOINT ["/usr/sbin/etcd"]
VOLUME ["/srv/etcd"]
