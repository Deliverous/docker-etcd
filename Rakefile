require '/home/oalbiez/wc/deliverous/tools/rake-docker/lib/rake/docker_lib'

Rake::DockerLib.new("registry.deliverous.net/deliverous/etcd", version: '0.5.0-alpha.1-1') do
    prepare do
        sh "CGO_ENABLED=0 go build -a --ldflags '-s -extldflags \"-static\"' github.com/coreos/etcd"
        sh 'strip', 'etcd'
    end
end
