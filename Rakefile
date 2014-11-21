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

task :t do
    ruby "#{Dir.glob('./test/**/test*.rb').map { |file| "\"#{file}\""}.join(" ")}" do |ok, status|
            if !ok && status.respond_to?(:signaled?) && status.signaled?
              raise SignalException.new(status.termsig)
            elsif !ok
              fail "Command failed with status (#{status.exitstatus})"
            end
          end
end