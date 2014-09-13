name             'django_tutorial'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures django_tutorial'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "application", "~> 3.0"
depends 'application_python'
depends 'application_nginx'
depends 'database'

