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
  $mypass = genpasswd
  /usr/bin/mysqladmin -u root password '$mypass'
  touch /tmp/mypass.txt && echo 'mypass' > /tmp/mypass.txt
  EOH
end

    service "mysqld" do
      supports :status => true, :restart => true, :reload => true
      action [:enable]
    end

end