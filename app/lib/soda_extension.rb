require 'net/https'
require 'uri'
require 'json'
require 'cgi'
require 'hashie'

module SODA
  class Client
    def initialize(config = {})
      @config = config.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    end

    # SODA::Client.new({:url => "http://data.cityofnewyork.us/api/views/erm2-nwe9/rows.json"})

    def get
      #(params = {})
      # Create query string of escaped key, value pairs
      #query = params.collect{ |key, val| "#{key}=#{CGI::escape(val.to_s)}" }.join("&")

      # If we didn't get a full path, assume "/resource/"
      # if !resource.start_with?("/")
      #   resource = "/resource/" + resource
      # end

      # Create our request
      uri = URI.parse("#{@config[:url]}")

      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = 10000
      http.use_ssl = false


      request = Net::HTTP::Get.new(uri.request_uri)
      # request.add_field("X-App-Token", @config[:app_token])

      # Authenticate if we're supposed to
      if @config[:username]
        request.basic_auth @config[:username], @config[:password]
      end

      # BAM!
      response = http.request(request)

      # Check our response code
      if response.code != "200"
        raise "Error querying \"#{uri.to_s}\": #{response.body}"
      else
        # Return a bunch of mashes
        response = JSON::parse(response.body)
        if response.is_a? Array
          return response.collect { |r| Hashie::Mash.new(r) }
        else
          return Hashie::Mash.new(response)
        end
      end
    end

    def post(resource, body = "", params = {})
      # Create query string of escaped key, value pairs
      query = params.collect{ |key, val| "#{key}=#{CGI::escape(val)}" }.join("&")

      # If we didn't get a full path, assume "/resource/"
      if !resource.start_with?("/")
        resource = "/resource/" + resource
      end

      # Create our request
      uri = URI.parse("https://#{@config[:domain]}#{resource}.json?#{query}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.request_uri)
      request.add_field("X-App-Token", @config[:app_token])
      request.content_type = "application/json"
      request.body = body.to_json

      # Authenticate if we're supposed to
      if @config[:username]
        request.basic_auth @config[:username], @config[:password]
      end

      # BAM!
      response = http.request(request)

      # Check our response code
      if response.code != "200"
        raise "Error querying \"#{uri.to_s}\": #{response.body}"
      else
        # Return a bunch of mashes
        response = JSON::parse(response.body)
        if response.is_a? Array
          return response.collect { |r| Hashie::Mash.new(r) }
        else
          return Hashie::Mash.new(response)
        end
      end
    end

    def put(resource, body = "", params = {})
      # Create query string of escaped key, value pairs
      query = params.collect{ |key, val| "#{key}=#{CGI::escape(val)}" }.join("&")

      # If we didn't get a full path, assume "/resource/"
      if !resource.start_with?("/")
        resource = "/resource/" + resource
      end

      # Create our request
      uri = URI.parse("https://#{@config[:domain]}#{resource}.json?#{query}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Put.new(uri.request_uri)
      request.add_field("X-App-Token", @config[:app_token])
      request.content_type = "application/json"
      request.body = body.to_json

      # Authenticate if we're supposed to
      if @config[:username]
        request.basic_auth @config[:username], @config[:password]
      end

      # BAM!
      response = http.request(request)

      # Check our response code
      if response.code != "200"
        raise "Error querying \"#{uri.to_s}\": #{response.body}"
      else
        # Return a bunch of mashes
        response = JSON::parse(response.body)
        if response.is_a? Array
          return response.collect { |r| Hashie::Mash.new(r) }
        else
          return Hashie::Mash.new(response)
        end
      end
    end
  end
end
