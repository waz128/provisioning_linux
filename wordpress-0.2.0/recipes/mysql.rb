api_string = (0...32).map{65.+(rand(25)).chr}.join
mypass = "#{api_string}"

if platform_family?("centos", "rhel")

  package "mysql-server" do
      action :install
    end

    service "mysqld" do
      supports :status => true, :restart => true, :reload => true
      action [:start ]
    end

    execute "assign-root-password" do
      action :run
      command "/usr/bin/mysqladmin -u root password '#{api_string}'"
    end
     
    service "mysqld" do
      supports :status => true, :restart => true, :reload => true
      action [:enable]
    end

end