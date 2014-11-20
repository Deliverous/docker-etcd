require 'rake/docker_lib'

Rake::DockerLib.new("registry.deliverous.net/deliverous/etcd", version: '0.5.0-alpha.1-1') do
    prepare do
        sh "CGO_ENABLED=0 go build -a --ldflags '-s -extldflags \"-static\"' github.com/coreos/etcd"
        sh 'strip', 'etcd'
    end

    test do
        image 'etcd-test'
        options '-p 4001:4001 -p 7001:7001'
        args '-peer-addr 127.0.0.1:7001 -addr 127.0.0.1:4001'
    end
end
