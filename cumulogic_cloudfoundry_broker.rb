ENV['RACK_ENV'] ||= 'development'

# Autoload gems from the Gemfile
require "bundler"
Bundler.require :default, ENV['RACK_ENV'].to_sym

require 'sqlite3'
require 'data_mapper'

# Define app and setup root helper
module CumulogicCloudfoundryBroker
  class Base < ::Sinatra::Base
    set :root, lambda { |*args| File.join(File.dirname(__FILE__), *args) }

    configure do
      DataMapper::Logger.new($stdout, :debug)
      dbfile = File.expand_path('../data.db', __FILE__)
      DataMapper.setup(:default, "sqlite://#{dbfile}")

      enable :logging
      enable :raise_errors, :logging
      enable :show_exceptions
      set :static_cache_control, [:private, max_age: 0, must_revalidate: true]

      # Register plugins
      register ::Sinatra::Namespace

      # Set default content type to json
      before do
        content_type :json
      end
    end

    use Rack::Auth::Basic, "Restricted Area" do |username, password|
      username == 'admin' and password == 'admin'
    end

    namespace '/cumulogic_cloudfoundry_bridge/v2' do

      before do
        good_api_version(
          request.env["HTTP_BROKER_API_VERSION"]
          ) if request.env["HTTP_BROKER_API_VERSION"]
      end

      get '/?' do
        json({ status: "success", message: "API v2" })
      end

    end
  end
end

require_relative 'model'
require_relative 'helpers/init'
require_relative 'routes/init'
require_relative 'models/init'
