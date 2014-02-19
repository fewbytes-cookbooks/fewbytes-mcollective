default['mcollective']['conf_dir'] = "/etc/mcollective"

case platform_family
when "debian"
	default['mcollective']['omnibus-package']['url'] = "http://public.fewbytes.com.s3.amazonaws.com/mcollective/mcollective_2.3.3-0.ubuntu.12.04_amd64.deb"
	default['mcollective']['omnibus-package']['checksum'] = "94474cef810959cb684b9f4451c8c1d2cadb36e630b340fe53cab366bdb97a12"
end