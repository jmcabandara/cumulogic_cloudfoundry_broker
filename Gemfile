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

source 'http://rubygems.org'

ruby '2.0.0'

gem 'cumulogic_client', :git => 'https://github.com/cumulogic/cumulogic_client.git'

# Sinatra microframework
gem 'rack'
gem 'rake'
gem 'sinatra', require: "sinatra/base"
gem 'sinatra-contrib'
gem 'multi_json'
gem 'sqlite3'
gem 'dm-sqlite-adapter'
gem 'data_mapper'

# Serve with unicorn
gem 'unicorn'

group :development, :test do
  gem 'guard-minitest'
end

group :test do
  gem 'rack-test', '~> 0.6.1'
  gem 'mocha', '~> 0.14.0', require: false
  gem 'simplecov', require: false
  gem 'coveralls', require: false
end
