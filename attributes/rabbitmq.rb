include_attribute 'rabbitmq'
default['rabbitmq']['enabled_plugins'] = ['rabbitmq_stomp']
default['rabbitmq']['virtualhosts'] = ['/mcollective']

default['rabbitmq']['enabled_users'] = [{
                                          name: 'mcollective',
                                          password: 'marionette',
                                          rights: [{ vhost: '/mcollective',
                                                     conf: '.*',
                                                     write: '.*',
                                                     read: '.*'
                                                     }]
}]
