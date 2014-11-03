require "#{ENV['WORKSPACE']}/tools/rake-docker/lib/rake/docker_lib"
require "#{ENV['WORKSPACE']}/tools/rake-utils/lib/rake/file_utils"

Rake::DockerLib.new("registry.deliverous.net/deliverous/etcd") do
  copy_if_obsolete "#{ENV['GOPATH']}/bin/etcd", 'etcd'
end
