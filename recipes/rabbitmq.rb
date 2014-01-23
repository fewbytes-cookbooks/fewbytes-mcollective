#
# Cookbook Name:: mcollective
# Recipe:: rabbitmq
#
# Copyright (C) 2013 AlexSHD
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'rabbitmq'

%w{ rabbitmq_web_stomp rabbitmq_stomp rabbitmq_management }.each do |plugin|
  rabbitmq_plugin plugin do
    action :enable
    notifies :restart, 'service[rabbitmq-server]'
  end
end

cookbook_file '/tmp/rabbitmq.sh' do
  source 'rabbitmq.sh'
  owner 'root'
  group 'root'
  mode '0644'
end

cookbook_file '/usr/local/bin/rabbitmqadmin' do
  source 'rabbitmqadmin'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :run, "execute[rabbitmq.sh]"
end

execute 'rabbitmq.sh' do
  command 'sh /tmp/rabbitmq.sh'
  creates '/tmp/rabbitHome'
  action :nothing
end
