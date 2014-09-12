if platform_family?("centos", "rhel")

  package "mysql-server" do
      action :install
    end

    service "mysqld" do
      supports :status => true, :restart => true, :reload => true
      action [:start ]
    end

    execute "assign-root-password" do
      def generate_passwd(length=8)  
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ23456789'  
      Array.new(length) { chars[rand(chars.length)].chr }.join
      end  
      action :run
      command "/usr/bin/mysqladmin -u root password '#{(generate_passwd())}'; echo '#{(generate_passwd())}' > /tmp/mysqlrootpass.txt"
    end

    service "mysqld" do
      supports :status => true, :restart => true, :reload => true
      action [:enable]
    end

end