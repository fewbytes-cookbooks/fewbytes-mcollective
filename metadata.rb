name             'fewbytes-mcollective'
maintainer       'Alex SHD'
maintainer_email 'alex@fewbytes.com'
license          'All rights reserved'
description      'Installs/Configures fewbytes-mcollective'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'apt'
depends 'ark'
depends 'rabbitmq'
depends 'runit'
