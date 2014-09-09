include_attribute "wordpress-0-2-0::random_password"

package "mysql55-server" do
	action :install
end

service "mysqld" do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end

default['mysql']['server_root_password'] = '#{random_password}'

file "/tmp/mysqlrootpass.txt" do
	action :create
	owner "root"
	group "root"
	mode "0644"
	content "#{random_password}"
end

puts '#{random_password}'