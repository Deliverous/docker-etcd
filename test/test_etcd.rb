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
end

class HttpConnection
    def initialize(container, options={})
        @container = container
        @port = options[:port] || 80
        @http = Net::HTTP.new @container.address, @port
    end

    def request(name, options={})
        data = options[:data]
        r = Net::HTTPGenericRequest.new(name, (data ? true : false), true, options[:path], options[:header])
        #r.body = data
        res = @http.request r, "polop"
        puts res.body.inspect
        #puts "#{name} #{options[:data]}"
        #@http.send_request(name, options[:path], options[:data], options[:header])
        res
    end

    def get(path)
        request('GET', path: path).body
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
        HttpConnection.new(@etcd, port: 4001).get('/version').must_equal 'etcd 0.5.0-alpha.1'
    end

    it "must store and restore value" do
        sleep 1
        connection = HttpConnection.new(@etcd, port: 4001)
        puts connection.request('PUT', path: '/v2/keys/mykey', data: 'this is awesome').inspect
        connection.get('/v2/keys/mykey').must_equal 'this is awesome'
    end
end
