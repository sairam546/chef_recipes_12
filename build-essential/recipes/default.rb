#
# Cookbook:: build-essential
# Recipe:: default
#
# Copyright:: 2008-2017, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Call the build-essential custom resource
# This can also be called directly in your cookbooks anywhere you want

# debian 6.0.x fails the build_essential recipe without an apt-get update prior to run
if platform?('debian', 'ubuntu')
  execute 'apt-get-update-periodic' do
    command 'apt-get update'
    ignore_failure true
    only_if do
      !File.exist?('/var/lib/apt/periodic/update-success-stamp') ||
        File.mtime('/var/lib/apt/periodic/update-success-stamp') < Time.now - 86400
    end
  end
end

build_essential 'install_packages' do
  compile_time node['build-essential']['compile_time']
end
