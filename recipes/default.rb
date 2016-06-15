#
# Cookbook Name:: webapp
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'apt::default'
include_recipe 'tar::default'

package ['ruby', 'libmysqlclient-dev', 'ruby-dev', 'vim', 'bundler'] do
  action :install
end

cookbook_file '/root/Gemfile' do
  source 'Gemfile'
  owner 'root'
  group 'root'
  mode '0600'
end

execute 'bundle install' do
	cwd '/root'
end

cookbook_file '/srv/webapp.tar.gz' do
	source 'webapp.tar.gz'
	owner 'root'
	group 'root'
	mode '0600'
end

directory '/srv/webapp' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

tar_extract '/srv/webapp.tar.gz' do
  action :extract_local
  target_dir '/srv/webapp'
  creates '/srv/webapp/views'
end


