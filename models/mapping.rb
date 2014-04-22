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
