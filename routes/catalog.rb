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

class CumulogicCloudfoundryBroker::Base < ::Sinatra::Base
  namespace '/cumulogic_cloudfoundry_bridge/v2' do

    get '/catalog' do
      #TODO: The catalog should be pulled from the CL controller

      cl = get_client()
      clplans = cl.get_serviceplans(userid(), nosqlserviceid())

      catalog = Catalog.new
      catalog.services = Array.new
      ms = Service.new
      ms.id = "cumulogic-service-#{nosqlserviceid()}"
      ms.name = 'cl-nosql'
      ms.description = 'CumuLogic NoSQL Services'
      ms.bindable = true
      ms.plans = Array.new

      def create_plan(clp)
        p = Plan.new
        p.id = "cl-nosql-#{clp['planId']}"
        p.name = clp['planName'].downcase.gsub(/\s+/, "")
        p.description = clp['planName']
        return p
      end

      clplans.each { |p| ms.plans.push(create_plan(p)) }
      
      catalog.services.push ms
      JSON.pretty_generate(catalog.to_hash)
    end

  end
end
