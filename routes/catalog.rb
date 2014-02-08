class CumulogicCloudfoundryBroker::Base < ::Sinatra::Base
  namespace '/cumulogic_cloudfoundry_bridge/v2' do

    get '/catalog' do
      catalog = Catalog.new
      catalog.services = Array.new
      ms = Service.new
      ms.id = '123'
      ms.name = 'mongodb'
      ms.description = 'good mongo db'
      ms.bindable = true
      #ms.plans = Array.new
      catalog.services.push ms
      puts catalog.services[0].name
      catalog.to_json
    end

  end
end
