package "mysql-server" do
  action :install
end

service "mysqld" do
  supports :status => true, :restart => true, :reload => true
  action [:start ]
end

bash "install something" do
  CHARS = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
    def self.random_password(length=10)
      CHARS.sort_by { rand }.join[0...length]
    end
  user "root"
  cwd "/tmp"
  code <<-EOH
  /usr/bin/mysqladmin -u root password '#{random_password}' >> mysqlpass.txt
  EOH
end

#execute "assign-root-password" do
  #CHARS = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
    #def self.random_password(length=10)
      #CHARS.sort_by { rand }.join[0...length]
    #end
  #action :run
  #command "/usr/bin/mysqladmin -u root password '#{random_password}' >> /tmp/mysqlpass.txt"
#end

service "mysqld" do
  supports :status => true, :restart => true, :reload => true
  action [:enable]
end

