class CumulogicCloudfoundryBroker::Base < ::Sinatra::Base
  namespace '/cumulogic_cloudfoundry_bridge/v2' do

    put '/service_instances/:id' do
      halt 409, JSON.pretty_generate({:description => "Service-instance already provisioned."}) if (Serviceinstance.count(:id => params[:id]) > 0)

      cl = get_client()

      request.body.rewind
      data = JSON.parse request.body.read

      spec = CumulogicClient::Nosql::NoSQLSpec.new()

      #TODO: Need to have the service details pulled from the catalog in CL controller
      
      spec.name = params[:id]
      spec.description = ''
      spec.nodes = "1"
      spec.collectionName = 'UnitTestCollection'
      spec.characterSet = 'UTF-8'
      spec.port = "27017"
      spec.noSqlEngineId = "1"
      spec.targetCloudId = "1"
      spec.instanceTypeId = "4"
      spec.serviceTag = 'Development'
      spec.accessGroupId = "0"
      spec.noSqlParamGroupId = "0"
      spec.storageSize = "10"
      spec.isbackupPreferenceSet = "0"
      spec.isAutoUpdateEnabled = "0"
      spec.ownerType = "1"
      spec.isAvailabilityZoneMandatory = "true"
      spec.isInstanceTypeMandatory = "true"
      spec.availabilityZone = "az-3.region-a.geo-1"
      spec.isVolumeSizeMandatory = "true"
      spec.backupRetentionPeriod = "1"
      spec.backupStartTime = ""
      spec.start = "1"

      noSqlInstanceId = cl.create(spec)

      #TODO: we have no method of dealing with the async nature of CL provisioning requests within CF

      Serviceinstance.create(
        :id   => params[:id],
        :service_id   => data[:service_id],
        :plan_id      => data[:plan_id],
        :organization_guid => data[:organization_guid],
        :space_guid => data[:space_guid],
        :instance_id => noSqlInstanceId
      )

      halt 201, JSON.pretty_generate({:id => params[:id]})
    end

    delete '/service_instances/:id' do
      begin
        si = Serviceinstance.get(params[:id])
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
