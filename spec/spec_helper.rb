#
# Cookbook Name:: delivery-cluster
# Spec:: spec_helper
#
# Author:: Salim Afiune (<afiune@chef.io>)
#
# Copyright:: Copyright (c) 2015 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chefspec'
require 'chefspec/berkshelf'

TOPDIR = File.expand_path(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

# Include all our libraries
Dir['libraries/*.rb'].each { |f| require File.expand_path(f) }

# Provisioning Drivers Data
module SharedDriverData
  extend RSpec::SharedContext

  let(:ssh_data) {
    {
      'ssh_username' => 'ubuntu',
      'prefix' => 'gksudo ',
      'key_file' => '/Users/afiune/.vagrant.d/insecure_private_key',
      'bootstrap_proxy' => 'http://my-proxy.com/',
      'chef_config' => "http_proxy 'http://my-proxy.com/'\nno_proxy 'localhost'"
    }
  }

  let(:vagrant_driver) {[]}

  let(:aws_driver) {[]}
end

RSpec.configure do |config|
  config.include SharedDriverData
  config.filter_run_excluding :ignore => true
  config.platform = 'ubuntu'
  config.version = '14.04'
end
