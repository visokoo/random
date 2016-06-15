#
# Cookbook Name:: webapp
# Recipe:: database 
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Configure the MySQL client.
mysql_client 'default' do
  action :create
end

# Configure the MySQL service.
mysql_service 'default' do
  version '5.5'
  port '3306'
  initial_root_password node['webapp']['database']['root_password']
  action [:create, :start]
end

# Install the mysql2 Ruby gem.
mysql2_chef_gem 'default' do
  action :install
end

# Create the database instance.
mysql_database node['webapp']['database']['dbname'] do
  connection(
    :host => node['webapp']['database']['host'],
    :username => node['webapp']['database']['root_username'],
    :password => node['webapp']['database']['root_password']
  )
  action :create
end

# Create a path to the SQL file in the Chef cache.
create_tables_script_path = File.join(Chef::Config[:file_cache_path], 'schema.sql')

# Write the SQL script to the filesystem.
cookbook_file create_tables_script_path do
  source 'schema.sql'
  owner 'root'
  group 'root'
  mode '0600'
end

# Seed the database with a table and test data.
execute "initialize #{node['webapp']['database']['dbname']} database" do
  command "mysql -h #{node['webapp']['database']['host']} -u #{node['webapp']['database']['root_username']} -p#{node['webapp']['database']['root_password']} -D #{node['webapp']['database']['dbname']} < #{create_tables_script_path}"
  not_if  "mysql -h #{node['webapp']['database']['host']} -u #{node['webapp']['database']['root_username']} -p#{node['webapp']['database']['root_password']} -D #{node['webapp']['database']['dbname']} -e 'describe items;'"
end

link '/var/run/mysqld/mysqld.sock' do 
  to '/run/mysql-default/mysqld.sock'
end
