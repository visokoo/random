#
# Cookbook Name:: webapp
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'apt::default'

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


