require 'cumulogic_client'

class CumulogicCloudfoundryBroker::Base < ::Sinatra::Base
  namespace '/cumulogic_cloudfoundry_bridge/v2' do

    put '/service_instances/:id' do
      halt 409, JSON.pretty_generate({:description => "Service-instance already provisioned."}) if (Serviceinstance.count(:id => params[:id]) > 0)

      request.body.rewind
      data = JSON.parse request.body.read

      Serviceinstance.create(
        :id   => params[:id],
        :service_id   => data[:service_id],
        :plan_id      => data[:plan_id],
        :organization_guid => data[:organization_guid],
        :space_guid => data[:space_guid],
        :instance_id => "foo"
      )

      halt 201, JSON.pretty_generate({:id => params[:id]})
    end

    delete '/service_instances/:id' do
      begin
        si = Serviceinstance.get(:id => params[:id])
        si.destroy()
      rescue
        puts 'Should have been there'
      end
      halt 200, "{}"
    end

  end

  #TODO: Figure out why this hack is needed
  namespace '/cumulogic_cloudfoundry_bridge/cumulogic_cloudfoundry_bridge/v2' do
    delete '/service_instances/:id' do
      status, headers, body = call env.merge("PATH_INFO" => "/cumulogic_cloudfoundry_bridge/v2/service_instances/#{params[:id]}")
    end
  end
end
