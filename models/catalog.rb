
class Catalog 
  attr_accessor :services
  def to_hash
    {'services' => @services.map { |s| s.to_hash } }
  end
end

class Service 
  attr_accessor :id
  attr_accessor :name
  attr_accessor :description
  attr_accessor :bindable
  attr_accessor :plans
  def to_hash
    { 'id' => @id,
      'name' => @name,
      'description' => @description,
      'bindable' => @bindable,
      'plans' => @plans.map { |p| p.to_hash }
    }
  end
end

class Plan 
  attr_accessor :id
  attr_accessor :name
  attr_accessor :description
  def to_hash
    { 'id' => @id,
      'name' => @name,
      'description' => @description
    }
  end
end
