class CumulogicCloudfoundryBroker::Base < ::Sinatra::Base
  namespace '/cumulogic_cloudfoundry_bridge/v2' do

    get '/catalog' do
      #TODO: The catalog should be pulled from the CL controller
      catalog = Catalog.new
      catalog.services = Array.new
      ms = Service.new
      ms.id = '123'
      ms.name = 'mongodb'
      ms.description = 'good mongo db'
      ms.bindable = true
      ms.plans = Array.new
      p1 = Plan.new
      p2 = Plan.new
      p1.id = '345'
      p1.name = 'plan1'
      p1.description = 'foo'
      p2.id = '567'
      p2.name = 'plan2'
      p2.description = 'bar'
      ms.plans.push p1
      ms.plans.push p2
      catalog.services.push ms
      puts catalog.services[0].name
      JSON.pretty_generate(catalog.to_hash)
    end

  end
end
