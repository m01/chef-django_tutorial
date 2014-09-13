#
# Cookbook Name:: django_tutorial
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# directories and users
directory "/srv/webapps" do
end

user "djtut" do
  :create
  home "/srv/webapps/django_tutorial"
end

directory "/srv/webapps/django_tutorial" do
  owner "djtut"
  group "djtut"
end
directory "/srv/webapps/django_tutorial/shared" do
  owner "djtut"
  group "djtut"
end

# database setup
include_recipe "database::mysql"
include_recipe "mysql::server"

mysql_connection_info = {
  :host     => '127.0.0.1',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

mysql_database 'django_tut' do
  connection mysql_connection_info
  action :create
end

# username max length = 16 chars
mysql_database_user 'django_tut_user' do
  connection mysql_connection_info
  password "123lol!"
  database_name 'django_tut'
  privileges [:all]
  action [:create, :grant]
end

# General application documentation:
# https://supermarket.getchef.com/cookbooks/application/versions/3.0.0#readme
application 'django_tutorial' do
  path  '/srv/webapps/django_tutorial'
  owner 'djtut'
  group 'djtut'

  packages ['git', 'ruby-all-dev']

  repository 'https://github.com/m01/django_tutorial.git'
  revision   'HEAD'

  # django & gunicorn documentation:
  # https://supermarket.getchef.com/cookbooks/application_python
  django do
    # defaults work fine
    collectstatic true
    debug true
    database do
      database 'django_tut'
      host mysql_connection_info[:host]
      adapter 'mysql'
      username 'django_tut_user'
      password '123lol!'
    end
  end

  migrate true

  gunicorn do
    app_module "django_tutorial.wsgi"
    # defaults
    port 8001
    autostart true
    logfile "/srv/webapps/django_tutorial/gunicorn.log"
  end

  # docs: http://cookbooks.opscode.com/cookbooks/application_nginx#readme
  nginx_load_balancer do
    static_files "/static" => "static"
    application_port 8001
  end
end

# ensure nginx is running. I don't understand why the above doesn't do that.
service 'nginx' do
  action [ :enable, :start ]
end

