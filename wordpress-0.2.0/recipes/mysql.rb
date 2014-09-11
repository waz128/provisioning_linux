CHARS = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
def random_password(length=10)
  CHARS.sort_by { rand }.join[0...length]
end

node.override['mysqld']['server_root_password'] = '#{random_password}'
print 'random_password'

package "mysql-server" do
  action :install
end

service "mysqld" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
  server_root_password = 'server_root_password'
end

