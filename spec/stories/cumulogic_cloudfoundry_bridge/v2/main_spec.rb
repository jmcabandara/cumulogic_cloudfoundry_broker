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

require_relative "../../../story_helper.rb"

describe "CumulogicCloudfoundryBroker::v2::Story" do
  it 'blocks unauthenticated access' do
    get '/cumulogic_cloudfoundry_bridge/v2/'
    assert_equal 401, last_response.status
  end

  it 'blocks bad credentials' do
    authorize 'admin', 'badpwd'
    get '/cumulogic_cloudfoundry_bridge/v2/'
    assert_equal 401, last_response.status
  end

  it 'allows good credentials' do
    authorize 'admin', 'admin'
    get '/cumulogic_cloudfoundry_bridge/v2/'
    assert_equal 200, last_response.status
  end

  it 'does not allow X-Broker-Api-Version < 2.0' do
    authorize 'admin', 'admin'
    get '/cumulogic_cloudfoundry_bridge/v2/', {}, 'HTTP_BROKER_API_VERSION' => '1.0'
    assert_equal 412, last_response.status
  end

  it 'allows X-Broker-Api-Version > 2.0' do
    authorize 'admin', 'admin'
    get '/cumulogic_cloudfoundry_bridge/v2/', {}, 'HTTP_BROKER_API_VERSION' => '2.1'
    assert_equal 200, last_response.status
  end

  it 'allows X-Broker-Api-Version = 2.0' do
    authorize 'admin', 'admin'
    get '/cumulogic_cloudfoundry_bridge/v2/', {}, 'HTTP_BROKER_API_VERSION' => '2.0'
    assert_equal 200, last_response.status
  end

  it 'errors with bad broker API version' do
    authorize 'admin', 'admin'
    get '/cumulogic_cloudfoundry_bridge/v2/', {}, 'HTTP_BROKER_API_VERSION' => '2.blah'
    assert_equal 412, last_response.status
  end

end
