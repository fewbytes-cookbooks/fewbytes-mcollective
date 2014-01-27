#
# Cookbook Name:: fewbytes-mcollective
# Recipe:: default
#
# Copyright (C) 2013 Alex SHD
#
# Appache v2 licence
#
include_recipe 'apt'

%w( vim vim-addon-manager git ).each do |p|
  package p
end

include_recipe 'fewbytes-mcollective::rabbitmq'
include_recipe 'fewbytes-mcollective::server'
include_recipe 'fewbytes-mcollective::client'
