include_attribute "mcollective::rabbitmq"

default['mcollective']['client']['config'] = {
  main_collective: 'mcollective',
  collectives: 'mcollective',
  libdir: ['/opt/mcollective/plugins', '/var/lib/mcollective/plugins'],
  logger_type: 'syslog',
  loglevel: 'warn',
  securityprovider: 'ssl',
  plugin: {
    yaml: '/etc/mcollective/facts.yaml',
    ssl_server_public: '/etc/mcollective/server-public.pem',
    ssl_client_private: '/etc/mcollective/john-private.pem',
    ssl_client_public: '/etc/mcollective/john-public.pem',
    rabbitmq: {
      vhost: node['mcollective']['rabbitmq']['virtualhost'],
      pool: {
        size: 1,
        1 => {
          # Sane default
          host: 'localhost',
          port: 61_613,
          user: node['mcollective']['rabbitmq']['user'],
          password: node['mcollective']['rabbitmq']['password']
        }
      }
    }
  },
  direct_addressing: 1,
  connector: 'rabbitmq',
  factsource: 'yaml'
}
