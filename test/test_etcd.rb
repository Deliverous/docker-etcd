require 'minitest/autorun'
require 'docker-tdd'
require 'rest_client'
require 'json'


describe "Etcd" do
    include DockerTdd::ContainerPlugin

    def containers
        @etcd = DockerTdd::Container.new ENV['DOCKER_IMAGE'], boottime: 1
    end

    it "must have the correct version" do
        RestClient.get(url('/version')).body.must_equal 'etcd 0.5.0-alpha.4'
    end

    it "must store and restore value" do
        RestClient.put(url('/v2/keys/message'), 'value=the value')
        JSON.parse(RestClient.get(url('/v2/keys/message')).body)['node']['value'].must_equal "the value"
    end

    def url(path)
        "http://#{@etcd.address}:2379#{path}"
    end
end
