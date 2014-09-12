CHARS = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
def random_password(length=10)
  CHARS.sort_by { rand }.join[0...length]
end

package "mysql-server" do
  action :install
end

service "mysqld" do
  supports :status => true, :restart => true, :reload => true
  action [:start ]
end

execute "mysqladmin" do
  command "/usr/bin/mysqladmin -u root password #{random_password}"
end

service "mysqld" do
  supports :status => true, :restart => true, :reload => true
  action [:enable]
end

file "pasword" do
  action :create
  owner "root"
  group "root"
  mode "0644"
  content "server_root_password"
end


