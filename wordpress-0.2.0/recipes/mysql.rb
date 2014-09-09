#The version parameter will allow the user to select from the versions available for the platform, where applicable. When omitted, it will install the default MySQL version for the target platform. Available version numbers are 5.0, 5.1, 5.5, and 5.6, depending on platform. See PLATFORMS.md for details.
#The port parameter determines the listen port for the mysqld service. When omitted, it will default to '3306'.
#The data_dir parameter determines where the actual data files are kept on the machine. This is useful when mounting external storage. When omitted, it will default to the platform's native location.
#The template_source parameter allows the user to override the default minimal template used by the mysql_service resource. When omitted, it will select one shipped with the cookbook based on the MySQL version.
#The allow_remote_root parameter allows the user to specify whether remote connections from the mysql root user. When set to true, it is recommended that it be used in combination with the root_network_acl parameter. When omitted, it will default to false.
#The remove_anonymous_users parameter allows the user to remove anonymous users often installed by default with during the mysql db initialization. When omitted, it defaults to true.
#The remove_test_database parameter allows the user to specify whether or not the test database is removed. When omitted, it defaults to true.
#The root_network_acl parameter allows the user to specify a list of subnets to accept connections for the root user from. When omitted, it defaults to none.
#The server_root_password parameter allows the user to specify the root password for the mysql database. This can be set explicitly in a recipe, driven from a node attribute, or from data_bags. When omitted, it defaults to ilikerandompasswords. Please be sure to change it.
#The server_debian_password parameter allows the user to specify the debian-sys-maint users password, used in log rotations and service management on Debian and Debian derived platforms.
#The server_repl_password parameter allows the user to specify the password used by 'repl'@'%', used in clustering scenarios. When omitted, it does not create the repl user or set a password.
#The mysql_service resource supports :create, :restart, and :reload actions.


CHARS = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
def random_password(length=10)
	CHARS.sort_by { rand }.join[0...length]
end

include_recipe 'mysql::server'

template '/etc/mysql/conf.d/mysite.cnf' do
  owner 'mysql'
  owner 'mysql'      
  source 'mysite.cnf.erb'
  notifies :restart, 'mysql_service[default]'
end

mysql_service 'default' do
  version '5.1'
  port '3306'
  data_dir '/data'
  template_source 'custom.erb'
  allow_remote_root true
  remove_anonymous_users false
  remove_test_database false
  server_root_password 'Hello128'
  server_repl_password 'sync_me_baby_one_more_time'
  action :create
end
