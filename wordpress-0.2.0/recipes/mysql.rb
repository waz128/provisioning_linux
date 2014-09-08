CHARS = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
def random_password(length=10)
	CHARS.sort_by { rand }.join[0...length]
end

package "mysql55-server" do
	action :install
end

service "mysqld" do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end

execute "name" do
	command "ls -la"
	creates "/tmp/something"
	action :run
end


execute "name" do
	command "/usr/bin/mysqladmin -u root password "#{random_password}"
	creates "/tmp/mysqlrootpass.txt"
	content '#{random_password}'
	action :run
end

puts '#{random_password}'