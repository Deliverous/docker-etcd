require "minitest/autorun"
require 'docker'
require 'rest_client'


class Container
    def initialize(name, options= {})
        @name = name
        @container = Docker::Container.create('Image' => name, 'Cmd' => options[:args])
    end

    def start
        @container.start
    end

    def stop
        @container.kill
        @container.delete(:force => true)
    end

    def address
        @container.json['NetworkSettings']['IPAddress']
    end
end

module ContainerPlugin
    def before_setup
        super
        containers if respond_to? :containers
        instance_variables.map {|name| instance_variable_get name }.each do |value|
            value.start if value.respond_to? :start
        end
    end

    def after_teardown
        super
        instance_variables.map {|name| instance_variable_get name }.each do |value|
            value.stop if value.respond_to? :stop
        end
    end
end


describe "Etcd" do
    include ContainerPlugin

    def containers
        @etcd = Container.new "registry.deliverous.net/deliverous/etcd:0.5.0-alpha.1-1", args: ["-bind-addr", "0.0.0.0:4001"]
    end

    it "must have the correct version" do
        sleep 1
        RestClient.get(url('/version')).body.must_equal 'etcd 0.5.0-alpha.1'
    end

    it "must store and restore value" do
        sleep 1
        RestClient.put(url('/v2/keys/mykey'), 'this is awesome')
        RestClient.get(url('/v2/keys/mykey')).body.must_equal 'this is awesome'
    end

    def url(path)
        "http://#{@etcd.address}:4001#{path}"
    end
end
