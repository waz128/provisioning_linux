CHARS = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
def random_password(length=10)
  CHARS.sort_by { rand }.join[0...length]
end

package "mysql-server" do
  action :install
  version " 5.5.38-1.0"
end


file "/tmp/mysql.txt" do
  action :create
  path "path"
  backup 5
  owner "root"
  group "root"
  mode "0644"
  content "#{random_password}"
end
