include_attribute "random_password"

package "mysql55-server" do
	action :install
end

service "mysqld" do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end

default['mysqld']['server_root_password'] = '#{random_password}'

file "/tmp/mysqlrootpass.txt" do
	action :create
	owner "root"
	group "root"
	mode "0644"
	content "#{random_password}"
end

puts '#{random_password}'