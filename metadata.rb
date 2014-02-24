name             'mcollective'
maintainer       'Alex SHD'
maintainer_email 'alex@fewbytes.com'
license          'All rights reserved'
description      'Installs/Configures mcollective'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'apt'       # `apt-get update` 
depends 'ark'       # plugin installation from `tar.gz` files
depends 'rabbitmq'  # rabbitmq
depends 'runit'     # mcollective server service ( initrd, that comes with omnibus pacage disabledd  )
depends 'git'