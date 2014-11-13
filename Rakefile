require 'rake/docker_lib'
require 'rake/copy_if_obsolete'

Rake::DockerLib.new("registry.deliverous.net/deliverous/etcd") do
  sh "CGO_ENABLED=0 go build -a --ldflags '-s -extldflags \"-static\"' github.com/coreos/etcd"
  sh 'strip', 'etcd'
end
