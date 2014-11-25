require 'rake/docker_lib'
require 'rake/git_lib'

EtcdVersion = "v0.5.0-alpha.1"

Rake::DockerLib.new("deliverous/etcd", version: "#{EtcdVersion}-1") do
    prepare do
        Git::updateto "git@github.com:Deliverous/etcd.git", path: "go/src/github.com/coreos/etcd", tag: EtcdVersion
        sh 'docker', 'run', '--rm', '-v', "#{Dir.pwd}/go:/go", '-e', 'CGO_ENABLED=0', 'golang:1.3.1', 'go', 'get', '-a', '--ldflags', '-s -extldflags \"-static\"', 'github.com/coreos/etcd'
        cp 'go/bin/etcd', 'etcd'
        sh 'strip', 'etcd'
    end
end
