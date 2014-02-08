# coding: utf-8

# Copyright 2014 CumuLogic, Inc
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

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cumulogic_cloudfoundry_broker/version'

Gem::Specification.new do |spec|
  spec.name          = "cumulogic_cloudfoundry_broker"
  spec.version       = CumulogicCloudfoundryBroker::VERSION
  spec.authors       = ["Chip Childers"]
  spec.email         = ["chip.childers@gmail.com"]
  spec.description   = %q{A Sinatra ruby application that provides a CloudFoundry Service Broker to integrate with CumuLogic services.}
  spec.summary       = %q{A Sinatra ruby application that provides a CloudFoundry Service Broker to integrate with CumuLogic services.}
  spec.homepage      = "https://github.com/cumulogic/cumulogic_cloudfoundry_broker"
  spec.license       = "ASLv2"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 2.0.0"
  spec.add_dependency "sinatra"
end
