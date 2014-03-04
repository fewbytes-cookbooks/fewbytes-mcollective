# fewbytes-mcollective cookbook

Installs mcollective from omnibus package.     
Coming with basic plugins preconfigured:
   
- service
- ping
- file
- completion
- facts
- filemgr

*For now supports only RabbitMQ

# Requirements

Omnibus package  - ['http://public.fewbytes.com.s3.amazonaws.com/mcollective/mcollective_2.3.3-0.ubuntu.12.04_amd64.deb'](link)
    
# Usage

### For server installation:

```
include_recipe 'mcollective::rabbitmq'
include_recipe 'mcollective::server'

```

### For client installation:

```
include_recipe 'mcollective::client'
```

## Plugin installation

Plugin installation is supported using the `mcollective_plugin` definition:

    mcollective_plugin "sysctl-data" do
        source "https://github.com/puppetlabs/mcollective-sysctl-data.git"
        provider :git
    end

Supported params:
- `provider` - :git, :ark or :s3
- `source` - URL of source repository or tarball
- `revision` - git branch or revision
- `checksum` - file checksum of ark/s3 tarballs/zipballs
- `strip_leading_dir` - whether to strip the leader directory when extracting the archive. defaults to `true`
- `aws_access_key_id` - for the S3 provider
- `aws_secret_access_key` - for the S3 provider

Some plugins may need an extra gem; When using mcollective-omnibus you can install the gem using the `mcollective_omnibus_gem` definition e.g.:

    mcollective_omnibus_gem "sys-proctable"

# Attributes

## atributes/{server.rb, client.rb}

Those files contains ruby hash that converted by the `libraries/config_renderer.rb` to mcollective configuration files.
This is giving us the ability to refer to all the configuration parameters as  

# Recipes

- mcollective::rabbitmq
- mcollective::server
- mcollective::client
- mcollective::plugins - install a few common plugins


# Author

Author:: Alex SHD (alex@fewbytes.com)
Author:: Avishai Ish-Shalom (avishai@fewbytes.com)

# TODO:

- remove duplicates from attributes server/client files
- key generator 
- RPM based distributions support
- ability to install via `chef_gem`
