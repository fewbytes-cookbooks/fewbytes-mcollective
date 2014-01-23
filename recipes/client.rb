#
# Cookbook Name:: mcollective
# Recipe:: client
#
# Copyright (C) 2013 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
file '/etc/mcollective/client.cfg' do
  extend ChefHelpers::Mcollective
  owner 'root'
  group 'root'
  mode '0644'
  content render(node['mcollective']['client']['config'])
end

cookbook_file '/etc/mcollective/john-private.pem' do
  source 'john-private.pem'
  owner 'root'
  group 'root'
  mode '0644'
end
