define :mcollective_plugin, :provider => :ark do
	plugin_dir = ::File.join(node["mcollective"]["extra_plugins_dir"], params[:name])
	deploy_dir = ::File.join(plugin_dir, "mcollective")
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

	directory plugin_dir do
		mode "0755"
	end
	
	# TODO: refactor so we don't repeat ourselves so much
	case params[:provider]
	when :ark
		ark params[:name] do
			path plugin_dir
			url params[:source]
			checksum params[:checksum] if params[:checksum]
			strip_leading_dir params[:strip_leading_dir] unless params[:strip_leading_dir].nil?
			action :put
			notifies :restart, "runit_service[mcollective-server-omnibus]"
		end
		link deploy_dir do
			to ::File.join(plugin_dir, params[:name])
		end
	when :s3
		include_recipe 'aws'
		s3url = RightAws::S3Interface.new(
				params[:aws_access_key_id],
				params[:aws_secret_access_key]
			).get_link(params[:bucket], params[:source])
		ark params[:name] do
			path plugin_dir
			url s3url
			checksum params[:checksum] if params[:checksum]
			strip_leading_dir params[:strip_leading_dir] unless params[:strip_leading_dir].nil?
			action :put
			notifies :restart, "runit_service[mcollective-server-omnibus]"
		end
		link deploy_dir do
			to ::File.join(plugin_dir, params[:name])
		end
	when :git
		git deploy_dir do
			repository params[:source]
			revision params[:revision] if params[:revision]
			action :sync
			notifies :restart, "runit_service[mcollective-server-omnibus]"
		end
	else
		raise RuntimeError, "Provider method #{params[:provider]} not implemented for mcollective_plugin definition"
	end
end
