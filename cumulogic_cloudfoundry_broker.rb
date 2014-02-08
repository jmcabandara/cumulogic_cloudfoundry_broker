ENV['RACK_ENV'] ||= 'development'

# Autoload gems from the Gemfile
require "bundler"
Bundler.require :default, ENV['RACK_ENV'].to_sym

class String
  def is_integer?
    self.to_i.to_s == self
  end
end

# Helpers
module JsonHelpers
  def json(hash)
    MultiJson.dump(hash, pretty: true)
  end

  def parsed_params
    if request.get? || request.form_data?
      parsed = params
    else
      parsed = MultiJson.load(request.body, symbolize_keys: true)
    end

    parsed = {} unless parsed.is_a?(Hash)

    return parsed
  end
end


# Define app and setup root helper
module CumulogicCloudfoundryBroker
  class Base < ::Sinatra::Base
    set :root, lambda { |*args| File.join(File.dirname(__FILE__), *args) }

    configure do
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

    helpers JsonHelpers

    use Rack::Auth::Basic, "Restricted Area" do |username, password|
      username == 'admin' and password == 'admin'
    end

    namespace '/cumulogic_cloudfoundry_bridge/v2' do

      before do
        if request.env["HTTP_BROKER_API_VERSION"]
          goodversion = false
          version = request.env["HTTP_BROKER_API_VERSION"]
          verarr = version.split(".")
          if verarr.length == 2 && 
            verarr[0].is_integer? && 
            verarr[1].is_integer? && 
            verarr[0].to_i == 2 && 
            verarr[1].to_i >= 0
            
            goodversion = true
          end
          if not goodversion
            halt 412, "Precondition Failed"
          end
        end
      end

      get '/?' do
        json({ status: "success", message: "API v2" })
      end

      get '/users' do
        users = ["bob", "andy", "john"]
        json({ status: "success", users: users })
      end

      post '/users' do
        user = parsed_params[:user]
        json({ status: "success", user: user })
      end

    end
  end
end
