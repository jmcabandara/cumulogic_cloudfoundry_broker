# Copyright (c) 2014 CumuLogic, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
