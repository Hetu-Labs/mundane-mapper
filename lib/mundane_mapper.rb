# frozen_string_literal: true

require 'sinatra/base'
require 'redis'
require 'regexp-examples'
require 'puma'
require_relative "mundane_mapper/version"

module MundaneMapper
  class Error < StandardError; end
  class Server < Sinatra::Base
    configure do
      set :server, :puma   # Set Sinatra to use Puma as the server
      set :redis, Redis.new(host: "localhost", port: 6379)

      # Assuming your views and public directories are located relative to this file.
      set :views, File.expand_path('../../../views', __FILE__)
      set :public_folder, File.expand_path('../../../public', __FILE__)
    end

    # Basic route to check server
    get "/" do
      "MundaneMapper is up and running!"
    end

    post "/mock/:endpoint" do
      # Placeholder logic; you'd integrate with Redis, validate requests, etc.
      "Mock POST response for #{params[:endpoint]}"
    end

    put "/mock/:endpoint" do
      # Placeholder logic
      "Mock PUT response for #{params[:endpoint]}"
    end

    # Error Handling
    error 401 do
      'Unauthorized'
    end

    # Starting and Stopping the Server
    def self.start(port: 4567)
      new.run! port: port
    end

    def self.stop
      Process.kill('INT', Process.pid)
    end
  end
end
