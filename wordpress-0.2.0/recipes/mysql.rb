package "mysql55-server" do
	action :install
end

service "mysqld" do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end

bash "mysql55-server" do
	user "root"
	code <<-EOH
	/usr/bin/mysqladmin -u root password 'Hello128'
	EOH
end
