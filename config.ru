require 'rubygems'
require 'bundler'
require 'bundler/setup'

Bundler.require

require File.expand_path('../lib/cumulogic_cloudfoundry_broker/broker', __FILE__)
CumulogicCloudfoundryBroker::Broker.run! :host => 'localhost', :port => 9090
