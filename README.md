django_tutorial Cookbook
========================
This cookbook deploys the django_tutorial sample Django app from
https://github.com/m01/django_tutorial

Requirements
------------
#### OS
Tested only on Ubuntu 14.04, but there's not much platform-specific stuff
in this cookbook.

#### packages
- `application` v3.0 - The overall web application cookbook
- `application_python` - For deploying django webapps using gunicorn
- `application_nginx` - For proxying requests to gunicorn
- `database` - For setting up MySQL

Attributes
----------
None

Usage
-----
Just edit the default.rb recipe to suit your needs.

There are probably more elegant ways to do things of course...


Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
License: MIT
Authors: Michiel
