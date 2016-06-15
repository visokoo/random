#
# Cookbook Name:: webapp
# Recipe:: unicorn
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'unicorn'

unicorn_app 'webapp' do
  action :create
  listen '0.0.0.0:8080'
  path '/srv/webapp'
end