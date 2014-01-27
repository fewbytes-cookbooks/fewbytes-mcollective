#
# Cookbook Name:: fewbytes-mcollective
# Recipe:: server
#
# Copyright (C) 2013 Alex SHD
#
# All rights reserved - Do Not Redistribute
#

remote_file "#{Chef::Config[:file_cache_path]}/mcollective-omnibus.deb" do
  source 'http://public.fewbytes.com.s3.amazonaws.com/mcollective/mcollective_2.3.3-0.ubuntu.12.04_amd64.deb'
  mode '0644'
  action :create_if_missing
end

dpkg_package 'mcollective' do
  source "#{Chef::Config[:file_cache_path]}/mcollective-omnibus.deb"
  action :install
end

directory '/etc/mcollective' do
  mode '0755'
end

file '/etc/mcollective/server.cfg' do
  extend ChefHelpers::Mcollective
  owner 'root'
  group 'root'
  mode '0644'
  content render(node['mcollective']['server']['config'])
  notifies :restart, "runit_service[mcollective-server-omnibus]"
end

%w{ server-private.pem server-public.pem john-public.pem }.each do |f|
  cookbook_file f do
    path "/etc/mcollective/#{f}"
    action :create
  end
end

service 'mcollective' do
  action [:disable, :stop]
end

include_recipe 'runit'

runit_service 'mcollective-server-omnibus'
