include_attribute 'rabbitmq'

default['mcollective']['rabbitmq']['collectives'] = ['mcollective']
default['mcollective']['rabbitmq']['virtualhost'] = 'mcollective'
default['mcollective']['rabbitmq']['user'] = 'mcollective'
default['mcollective']['rabbitmq']['password'] = 'mcollective'

default['rabbitmq']['enabled_plugins'] = ['rabbitmq_stomp']
default['rabbitmq']['virtualhosts'] << node['mcollective']['rabbitmq']['virtualhost']