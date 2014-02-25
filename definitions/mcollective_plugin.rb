define :mcollective_plugin, :provider => :ark do
	plugin_dir = ::File.join(node["mcollective"]["extra_plugins_dir"], params[:name])
	node.default['mcollective']['server']['config']['libdir'] << plugin_dir
	node.default['mcollective']['client']['config']['libdir'] << plugin_dir

	raise RuntimeError, "You must provide source param" unless params[:source]
	
	begin
		resources(:directory => node['mcollective']['extra_plugins_dir'])
	rescue Chef::Exceptions::ResourceNotFound 
		directory node['mcollective']['extra_plugins_dir'] do
			mode "0755"
		end
	end

	case params[:provider]
	when :ark
		ark plugin_dir do
			source params[:source]
			checksum params[:checksum] if params[:checksum]
			action :put
			notifies :restart, "runit_service[mcollective-server-omnibus]"
		end
	when :git
		git plugin_dir do
			repository params[:source]
			revision params[:revision] if params[:revision]
			action :sync
			notifies :restart, "runit_service[mcollective-server-omnibus]"
		end
	else
		raise RuntimeError, "Provider method #{params[:provider]} not implemented for mcollective_plugin definition"
	end
end