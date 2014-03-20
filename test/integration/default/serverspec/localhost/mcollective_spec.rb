require 'spec_helper'

describe package("rabbitmq-server") do
	it {should be_installed}	
end

describe service("mcollectived") do
	it { should_not be_enabled }
end

describe service("mcollective-server-omnibus") do
	it { should be_running }
end

describe port(61613) do
	it { should be_listening }
end

describe file("/etc/mcollective/server.cfg") do
	its(:content) { should match /plugin.rabbitmq.pool.1.host = localhost/ }
end

describe command("rabbitmqctl list_exchanges -p mcollective") do
	it { should return_stdout /mcollective_/ }
end

describe command("mco ping -1 --np --dt 1 -t 1") do
	it { should return_exit_status 1 }
	it { should return_stdout /time=/ }
end