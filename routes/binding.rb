class CumulogicCloudfoundryBroker::Base < ::Sinatra::Base
  namespace '/cumulogic_cloudfoundry_bridge/v2' do

    put '/service_instances/:instance_id/service_bindings/:id' do

      halt 409, JSON.pretty_generate({:description => "Binding already created."}) if (Servicebinding.count(:id => params[:id]) > 0)

      cl = get_client()

      noSqlInstanceId = Serviceinstance.get(params[:instance_id]).instance_id

      #TODO: Query for DB name (collection name) from CL
      collectionName = "UnitTestCollection"

      creds = cl.get(noSqlInstanceId)

      request.body.rewind
      data = JSON.parse request.body.read

      Servicebinding.create(
        :id => params[:id],
        :service_id => data[:service_id],
        :plan_id => data[:plan_id],
        :app_guid => data[:app_guid]
      )

      halt 201, JSON.pretty_generate(
        {
          :credentials => 
            {
            :uri => "mongodb://#{creds[0]["hostName"]}:#{creds[0]["port"]}/#{collectionName}",
            :username => creds[0]["username"],
            :password => creds[0]["password"],
            :host => creds[0]["hostName"],
            :port => creds[0]["port"],
            :database => collectionName
            }
        }
      )
    end

    delete '/service_instances/:instance_id/service_bindings/:id' do
      begin
        sb = Servicebinding.get(params[:id])
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
