require 'minitest/autorun'
require 'docker-tdd'
require 'rest_client'


describe "Etcd" do
    include DockerTdd::ContainerPlugin

    def containers
        @etcd = DockerTdd::Container.new "registry.deliverous.net/deliverous/etcd:0.5.0-alpha.1-1", args: ["-bind-addr", "0.0.0.0:4001"]
    end

    it "must have the correct version" do
        sleep 1
        RestClient.get(url('/version')).body.must_equal 'etcd 0.5.0-alpha.1'
    end

    it "must store and restore value" do
        sleep 1
        RestClient.put(url('/v2/keys/message'), 'value=the value')
        RestClient.get(url('/v2/keys/message')).body.must_equal "{\"action\":\"get\",\"node\":{\"key\":\"/message\",\"value\":\"the value\",\"modifiedIndex\":4,\"createdIndex\":4}}\n"
    end

    def url(path)
        "http://#{@etcd.address}:4001#{path}"
    end
end
