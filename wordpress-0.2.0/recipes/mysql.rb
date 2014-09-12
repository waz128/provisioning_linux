package "mysql-server" do
  action :install
end

service "mysqld" do
  supports :status => true, :restart => true, :reload => true
  action [:start ]
end

execute "assign-root-password" do
  Chef::Provider::Log::ChefLog
  CHARS = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
    def self.random_password(length=10)
      CHARS.sort_by { rand }.join[0...length]
    end
  command "/usr/bin/mysqladmin -u root password '#{random_password}'"
  log ("#{random_password}") { level :info }
  action :run
end

service "mysqld" do
  supports :status => true, :restart => true, :reload => true
  action [:enable]
end

