
class Catalog 
  attr_accessor :services
  def to_json
    {'services' => @services.to_json }
  end
end

class Service 
  attr_accessor :id
  attr_accessor :name
  attr_accessor :description
  attr_accessor :bindable
  attr_accessor :plans
  def to_json
    { 'id' => @id,
      'name' => @name,
      'description' => @description,
      'bindable' => @bindable
    }.to_json
  end
end

class Plan 
  attr_accessor :id
  attr_accessor :name
  attr_accessor :description
end
