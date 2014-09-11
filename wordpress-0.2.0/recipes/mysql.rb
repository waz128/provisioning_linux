CHARS = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
def random_password(length=10)
  CHARS.sort_by { rand }.join[0...length]
end

package "mysql-server" do
  action :install
  version " 5.5.38-1.0"
end

mysql_service node['mysql']['service_name'] do
  version node['mysql']['version']
  port node['mysql']['port']
  data_dir node['mysql']['data_dir']
  server_root_password node['mysql']['#{random_password}']
  server_debian_password node['mysql']['server_debian_password']
  server_repl_password node['mysql']['server_repl_password']
  allow_remote_root node['mysql']['allow_remote_root']
  remove_anonymous_users node['mysql']['remove_anonymous_users']
  remove_test_database node['mysql']['remove_test_database']
  root_network_acl node['mysql']['root_network_acl']
  package_version node['mysql']['server_package_version']
  package_action node['mysql']['server_package_action']
  action :create
end

file "/tmp/mysql.txt" do
  action :create
  path "path"
  backup 5
  owner "root"
  group "root"
  mode "0644"
  content "#{random_password}"
end
