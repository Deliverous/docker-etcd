require 'minitest/autorun'
require 'docker-tdd'
require 'rest_client'


describe "Etcd" do
    include DockerTdd::ContainerPlugin

    def containers
        @etcd = DockerTdd::Container.new ENV['DOCKER_IMAGE'], args: ["-bind-addr", "0.0.0.0:4001"], boottime: 1
    end

    it "must have the correct version" do
        RestClient.get(url('/version')).body.must_equal 'etcd 0.5.0-alpha.3'
    end

    it "must store and restore value" do
        RestClient.put(url('/v2/keys/message'), 'value=the value')
        RestClient.get(url('/v2/keys/message')).body.must_equal "{\"action\":\"get\",\"node\":{\"key\":\"/message\",\"value\":\"the value\",\"modifiedIndex\":3,\"createdIndex\":3}}\n"
    end

    def url(path)
        "http://#{@etcd.address}:4001#{path}"
    end
end
