class Serviceinstance
  include DataMapper::Resource

  property :id,                 String, :key => true
  property :service_id,         String
  property :plan_id,            String
  property :organization_guid,  String
  property :space_guid,         String
  property :instance_id,        String
  has n, :bindings
end

class Binding
  include DataMapper::Resource

  property :id,                 String, :key => true
  property :service_id,         String
  property :plan_id,            String
  property :app_guid,           String
  belongs_to :serviceinstance
end

DataMapper.finalize

DataMapper.auto_upgrade!
