require 'rake/docker_lib'
require 'rake/compile_go'

EtcdVersion = "v0.5.0-alpha.4"

Rake::DockerLib.new("deliverous/etcd", version: "#{EtcdVersion}-1") do
    prepare do
        Go::compilation(workspace: "#{Dir.pwd}/go", goversion: "1.3.3") do
            repository 'https://github.com/coreos/etcd.git', path: 'github.com/coreos/etcd', tag: EtcdVersion
            build 'github.com/coreos/etcd', static: true
            strip_binaries
            copy_to Dir.pwd
        end
    end
end
