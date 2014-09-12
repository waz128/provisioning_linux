if platform_family?("centos", "rhel")

  package "mysql-server" do
      action :install
    end

    service "mysqld" do
      supports :status => true, :restart => true, :reload => true
      action [:start ]
    end

    execute "assign-root-password" do

      MYCONSTANT = "random_password"
      CHARS = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
      def random_password(length=10)
      CHARS.sort_by { rand }.join[0...length]
      end
      action :run
      command "/usr/bin/mysqladmin -u root password '#{MYCONSTANT}'";
    end

    service "mysqld" do
      supports :status => true, :restart => true, :reload => true
      action [:enable]
    end

end