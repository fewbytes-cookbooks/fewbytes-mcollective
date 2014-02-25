define :mcollective_omnibus_gem do
	gem_package params[:name] do
		gem_binary "/opt/mcollective/embedded/bin/gem"
		notifies :restart, "runit_service[mcollective-server-omnibus]"
	end
end