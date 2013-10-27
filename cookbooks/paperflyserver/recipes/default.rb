#
# Cookbook Name:: paperflyserver
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "mysql::client"
include_recipe "mysql::server"
include_recipe "mysql::ruby"
include_recipe "java"

#Create Production-Database for PF
mysql_database node['paperflyserver']['database'] do
  connection ({
                                :host => 'localhost', 
                                :username => 'root', 
                                :password => node['mysql']['server_root_password']})
  action                      :create
end

# Create Test-Database for WLC
mysql_database node['paperflyserver']['test_database'] do
  connection ({
                                :host => 'localhost',
                                :username => 'root',
                                :password => node['mysql']['server_root_password']})
  action                      :create
end

# Create Database-User and grant access for Production-Database
mysql_database_user node['paperflyserver']['database_username'] do
  connection ({
                                :host => 'localhost', 
                                :username => 'root', 
                                :password => node['mysql']['server_root_password']})
  password                    node['wlcserver']['database_password']
  database_name               node['wlcserver']['database']
  privileges                  [:select,:update,:insert,:create,:delete]
  action                      :grant
end

# Create Database-User and grant access for Test-Database
mysql_database_user node['paperflyserver']['database_username'] do
  connection ({
                                :host => 'localhost',
                                :username => 'root',
                                :password => node['mysql']['server_root_password']})
  password                    node['wlcserver']['database_password']
  database_name               node['wlcserver']['test_database']
  privileges                  [:select,:update,:insert,:create,:delete]
  action                      :grant
end