#
# Cookbook Name:: fewbytes-mcollective
# Recipe:: default
#
# Copyright (C) 2013 Alex SHD
#
# Appache v2 licence
#
include_recipe 'apt'

include_recipe 'mcollective::rabbitmq'
include_recipe 'mcollective::server'
include_recipe 'mcollective::plugins'
include_recipe 'mcollective::client'
