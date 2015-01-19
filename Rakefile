require 'rake/docker_lib'
require 'rake/compile_go'

EtcdVersion = ENV["VERSION_ETCD"]

Rake::DockerLib.new("deliverous/etcd", version: "#{EtcdVersion}-1") do
    prepare do
        Go::compilation(workspace: "#{Dir.pwd}/go", goversion: ENV["VERSION_GOLANG"]) do
            repository 'https://github.com/coreos/etcd.git', path: 'github.com/coreos/etcd', tag: EtcdVersion
            build 'github.com/coreos/etcd', static: true
            strip_binaries
            copy_to Dir.pwd
        end
    end
end
