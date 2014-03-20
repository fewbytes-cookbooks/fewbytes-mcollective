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

rabbitmq_vhost node['mcollective']['rabbitmq']['virtualhost'] do
  action :add
end

rabbitmq_user node['mcollective']['rabbitmq']['user'] do
  action [:add, :set_permissions]
  vhost node['mcollective']['rabbitmq']['virtualhost']
  password node['mcollective']['rabbitmq']['password']
  permissions ".* .* .*"
end

chef_gem "bunny"

ruby_block "declare rabbitmq exchanges for collectives" do
  block do
    require 'bunny'
    conn = Bunny.new(
      :vhost => node["mcollective"]["rabbitmq"]["virtualhost"],
      :user => node['mcollective']['rabbitmq']['user'],
      :password => node['mcollective']['rabbitmq']['password'],
      :keepalive => true
    )
    conn.start
    ch = conn.create_channel
    node['mcollective']['rabbitmq']['collectives'].each do |collective|
      ch.topic("#{collective}_broadcast", :auto_delete => false, :durable => true)
      ch.direct("#{collective}_directed", :auto_delete => false, :durable => true)
    end
    ch.close
    conn.close
  end
end
