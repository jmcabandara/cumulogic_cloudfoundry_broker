class Serviceinstance
  include DataMapper::Resource

  property :id,                 String, :key => true
  property :service_id,         String
  property :plan_id,            String
  property :organization_guid,  String
  property :space_guid,         String
  property :instance_id,        String
end

class Servicebinding
  include DataMapper::Resource

  property :id,                 String, :key => true
  property :service_id,         String
  property :plan_id,            String
  property :app_guid,           String

end

DataMapper.finalize

DataMapper.auto_upgrade!
#DataMapper.auto_migrate!
