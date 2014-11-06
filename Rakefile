require 'rake/docker_lib'
require 'rake/copy_if_obsolete'

Rake::DockerLib.new("registry.deliverous.net/deliverous/etcd") do
  copy_if_obsolete "#{ENV['GOPATH']}/bin/etcd", 'etcd'
  sh 'strip', 'etcd'
end
