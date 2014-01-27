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

```
depends 'apt'
depends 'ark'
depends 'rabbitmq'
depends 'runit'
```
    
# Usage

### For server installation:

```
include_recipe 'fewbytes-mcollective::rabbitmq'
include_recipe 'fewbytes-mcollective::server'

```

### For client installation:

```
include_recipe 'fewbytes-mcollective::client'
```

# Attributes

## atributes/{server.rb, client.rb}

Those files contains ruby hash that converted by the `libraries/config_renderer.rb` to mcollective configuration files.
This is giving us the ability to refer to all the configuration parameters as  

# Recipes

- fewbytes-mcollective::rabbitmq
- fewbytes-mcollective::server
- fewbytes-mcollective::client


# Author

Author:: Alex SHD (alex@fewbytes.com)

# TODO:

- Plugins installation
- remove duplicates from attributes server/client files
- key generator 
- RPM based distributions support
- ability to install via `chef_gem`
