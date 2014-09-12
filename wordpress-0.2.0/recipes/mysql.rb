package "mysql-server" do
  action :install
end

service "mysqld" do
  supports :status => true, :restart => true, :reload => true
  action [:start ]
end

execute "assign-root-password" do
  CHARS = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
    def self.random_password(length=10)
      CHARS.sort_by { rand }.join[0...length]
    end
  action :run
  command "/usr/bin/mysqladmin -u root password '#{random_password}'"
 action: run
  provider Chef::Provider::Log::ChefLog
  log "#{random_password}"
  cwd "tmp"
end

service "mysqld" do
  supports :status => true, :restart => true, :reload => true
  action [:enable]
end


execute "name" do
  action :run
  command "ls -la"
  creates "/tmp/something"
  cwd "/tmp"
  environment ({'HOME' => '/home/myhome'})
  user "root"
  group "root"
  path "['/opt/bin','/opt/sbin']"
  timeout 3600
  returns 0
  umask "022"
end
