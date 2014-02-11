class CumulogicCloudfoundryBroker::Base < ::Sinatra::Base
  namespace '/cumulogic_cloudfoundry_bridge/v2' do

    put '/service_instances/:instance_id/service_bindings/:id' do
      halt 201, JSON.pretty_generate(
        {
          :instance_id => params[:instance_id], 
          :id => params[:id],
          :credentials => 
            {
            :uri => "mongodb://15.185.222.159:27017/UnitTestCollection",
            :username => "",
            :password => "",
            :host => "15.185.222.159",
            :port => 27017,
            :database => "UnitTestCollection"
            }
        }
      )
    end

    delete '/service_instances/:instance_id/service_bindings/:id' do
      begin
        sb = Serviceinstance.get(:id => params[:id])
        sb.destroy()
      rescue
        puts 'Should have been there'
      end
      halt 200, "{}"
    end

  end

  #TODO: Figure out why this hack is needed
  namespace '/cumulogic_cloudfoundry_bridge/cumulogic_cloudfoundry_bridge/v2' do
    delete '/service_instances/:instance_id/service_bindings/:id' do
      status, headers, body = call env.merge("PATH_INFO" => "/cumulogic_cloudfoundry_bridge/v2/service_instances/#{params[:instance_id]}/service_bindings/#{params[:id]}")
    end
  end
end
