# Generates a random string from a set of easily readable characters
def generate_activation_code(size = 6)
  charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
  (0...size).map{ charset.to_a[rand(charset.size)] }.join
end
generate_activation_code = "#{api_string}"

if platform_family?("centos", "rhel")

  package "mysql-server" do
      action :install
    end

    service "mysqld" do
      supports :status => true, :restart => true, :reload => true
      action [:start ]
    end

    execute "assign-root-password" do
      command "/usr/bin/mysqladmin -u root password '#{api_string}'"
      action :run
    end
     
 
    service "mysqld" do
      supports :status => true, :restart => true, :reload => true
      action [:enable]
    end

end