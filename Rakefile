require 'rake/docker_lib'
require 'rake/compile_go'

EtcdVersion = "v0.5.0-alpha.3"

Rake::DockerLib.new("deliverous/etcd", version: "#{EtcdVersion}-1") do
    prepare do
        Go::compile(repository: 'git@github.com:Deliverous/etcd.git',
                    package: 'github.com/coreos/etcd',
                    tag: EtcdVersion,
                    workspace: "#{Dir.pwd}/go",
                    goversion: "1.3.3",
                    target: "#{Dir.pwd}",
                    static: true,
                    strip: true)
    end
end
