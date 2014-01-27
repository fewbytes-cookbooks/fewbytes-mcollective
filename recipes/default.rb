#
# Cookbook Name:: fewbytes-mcollective
# Recipe:: default
#
# Copyright (C) 2013 Alex SHD
#
# Appache v2 licence
#
include_recipe 'apt'

include_recipe 'fewbytes-mcollective::rabbitmq'
include_recipe 'fewbytes-mcollective::server'
include_recipe 'fewbytes-mcollective::client'
