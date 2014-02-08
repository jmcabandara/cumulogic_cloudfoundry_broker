#require 'rack'
require 'sinatra/base'

#use Rack::Auth::Basic, "Restricted Area" do |username, password|
#  username == 'admin' and password == 'admin'
#end

class CumulogicCloudfoundryBroker::Broker < Sinatra::Base
  get "/" do
    "Hello world"
  end
end
