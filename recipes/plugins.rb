#
# Cookbook Name:: mcollective
# Recipe:: plugins
#
# Copyright (C) 2013 AlexSHD
#
# All rights reserved - Do Not Redistribute
#

include_recipe "git"

mcollective_plugin "opscodeohai-facts" do
	source "https://github.com/puppetlabs/mcollective-ohai-facts.git"
	provider :git
end

node.default['mcollective']['server']['config']['factsource'] = 'opscodeohai'

mcollective_plugin "sysctl-data" do
	source "https://github.com/puppetlabs/mcollective-sysctl-data.git"
	provider :git
end

mcollective_plugin "filemgr-agent" do
	source "https://github.com/puppetlabs/mcollective-filemgr-agent.git"
	provider :git
end

mcollective_plugin "service-agent" do
	source "https://github.com/puppetlabs/mcollective-service-agent.git"
	provider :git
end