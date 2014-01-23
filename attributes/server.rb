default['mcollective']['server']['config'] = {
  main_collective: 'mcollective',
  collectives: 'mcollective',
  libdir: ['/opt/mcollective/plugins', '/var/lib/mcollective/plugins'],
  logger_type: 'syslog',
  loglevel: 'warn',
  securityprovider: 'ssl',
  plugin: {
    yaml: '/etc/mcollective/facts.yaml',
    ssl_server_private: '/etc/mcollective/server-private.pem',
    ssl_server_public: '/etc/mcollective/server-public.pem',
    ssl_client_cert_dir: '/etc/mcollective/',
    ssl: {
      enforce_ttl: 0
    },
    rabbitmq: {
      vhost: '/',
      pool: {
        size: 1,
        1 => {
          host: 'localhost',
          port: 61_613,
          user: 'guest',
          password: 'guest'
        }
      }
    }
  },
  direct_addressing: 1,
  connector: 'rabbitmq',
  factsource: 'yaml'
}
