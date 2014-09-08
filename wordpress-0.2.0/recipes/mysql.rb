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

bash "mysql" do
	Chef::Provider::Script::Bash
	user "root"
	code <<-EOH
	/usr/bin/mysqladmin -u root password '#{random_password}'
	EOH
end

file "/tmp/mysqlrootpass.txt" do
	action :create
	owner "root"
	group "root"
	mode "0644"
	content "#{random_password}"
end


puts '#{random_password}'