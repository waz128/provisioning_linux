if platform_family?("centos", "rhel")

  package "mysql-server" do
      action :install
    end

    service "mysqld" do
      supports :status => true, :restart => true, :reload => true
      action [:start ]
    end

bash "assign-root-password" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  /usr/bin/mysqladmin -u root password 'genpasswd' > /tmp/mysqlroot.txt
  EOH
end

    service "mysqld" do
      supports :status => true, :restart => true, :reload => true
      action [:enable]
    end

end