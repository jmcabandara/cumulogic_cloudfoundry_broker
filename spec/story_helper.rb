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

require_relative "spec_helper"
require_relative "support/story_helpers.rb"

require 'rack/test'

class StoryTest < UnitTest
  include Rack::Test::Methods
  include StoryHelpers

  register_spec_type(/Story$/, self)

  def app
    CumulogicCloudfoundryBroker::Base
  end
end
