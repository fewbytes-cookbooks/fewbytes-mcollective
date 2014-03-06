default['mcollective']['conf_dir'] = "/etc/mcollective"
default['mcollective']['lib_dir'] = "/var/lib/mcollective"

case platform_family
when "debian"
	default['mcollective']['omnibus-package']['url'] = "http://public.fewbytes.com/mcollective/mcollective_2.4.1-0_amd64.deb"
	default['mcollective']['omnibus-package']['checksum'] = "c339fae4bdda57a16fb876847f55b339ffdcf3d1b70aaf8a15f381d1d9239783"
when "rhel"
	default['mcollective']['omnibus-package']['url'] = "http://public.fewbytes.com/mcollective/mcollective-2.4.1-0.el6.x86_64.rpm"
  default['mcollective']['omnibus-package']['checksum'] = "a0dd51eaf21e1db5af832ce91c0f7b1cd6bcd2efa4d820ffb9e780c0d54a042a"
end

default['mcollective']['extra_plugins_dir'] = "/var/lib/mcollective/extra_plugins"
