#
# Cookbook Name:: mcollective
# Recipe:: server
#
# Copyright (C) 2013 Alex SHD
#
# All rights reserved - Do Not Redistribute
#

remote_file "#{Chef::Config[:file_cache_path]}/mcollective-omnibus.deb" do
  source node["mcollective"]["omnibus-package"]["url"]
  checksum node["mcollective"]["omnibus-package"]["checksum"]
  mode '0644'
  action :create_if_missing
end

case node.platform_family
  when 'debian'
  dpkg_package 'mcollective' do
    source "#{Chef::Config[:file_cache_path]}/mcollective-omnibus.deb"
    action :install
  end
end

directory node['mcollective']['conf_dir'] do
  mode '0755'
end

file ::File.join(node['mcollective']['conf_dir'], 'server.cfg') do
  extend ChefHelpers::Mcollective
  owner 'root'
  group 'root'
  mode '0644'
  content lazy { render(node['mcollective']['server']['config'].to_hash) }
  notifies :restart, "runit_service[mcollective-server-omnibus]"
end

%w{ server-private.pem server-public.pem john-public.pem }.each do |f|
  cookbook_file ::File.join(node['mcollective']['conf_dir'] ,f) do
    mode "0600"
    action :create
  end
end

file node['mcollective']['server']['config']['classesfile'] do
  mode "0644"
  content (node.recipes.map{|r| "recipe.#{r}"} + node.roles.map{|r| "role.#{r}"}).join("\n")
end

service 'mcollective' do
  action [:disable, :stop]
end

include_recipe 'runit'

runit_service 'mcollective-server-omnibus'
