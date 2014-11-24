require '/home/oalbiez/wc/deliverous/tools/rake-docker/lib/rake/docker_lib'

Rake::DockerLib.new("deliverous/etcd", version: '0.5.0-alpha.3-1') do
    prepare do
        sh "CGO_ENABLED=0 go build -a --ldflags '-s -extldflags \"-static\"' github.com/coreos/etcd"
        sh 'strip', 'etcd'
    end
end
