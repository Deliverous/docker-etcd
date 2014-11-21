require "minitest/autorun"
require "minitest"
require 'docker'
require 'net/http'
require 'uri'


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

    def http(options={})
        Net::HTTP.get(URI("http://#{address}:#{options[:port] || 80}/#{options[:path] || ''}"))
    end
end

module ContainerPlugin
    def before_setup
        super
        containers if respond_to? :containers
        instance_variables.map {|name| instance_variable_get name }.each do |value|
            value.start if value.instance_of? Container
        end
    end

    def after_teardown
        super
        instance_variables.map {|name| instance_variable_get name }.each do |value|
            value.stop if value.instance_of? Container
        end
    end
end


describe "Etcd" do
    include ContainerPlugin

    def containers
        @etcd = Container.new "registry.deliverous.net/deliverous/etcd:0.5.0-alpha.1-1", args: ["-bind-addr", "0.0.0.0:4001"]
    end

    it "must have the correct version" do
        @etcd.http(port: 4001, path: 'version').must_equal 'etcd 0.5.0-alpha.1'
    end

end
