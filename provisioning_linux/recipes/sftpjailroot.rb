#Generate random  password
randompass = (0...32).map{65.+(rand(25)).chr}.join
$pass = "#{randompass}"

if platform_family?("centos", "rhel")

		user "waseemtest" do
			action :create
			supports :manage_home => true
			system true
			comment "Jail Root sFTP user"
			home '/home/waseemtest'
			shell "/sbin/nologin"
			password "#{randompass}" 
		end
			group "sftpusers" do
			system true
			action :create
			members ['waseemtest','apache']
		end

		directory "/home/waseemtest/public_html" do
			action :create
			owner "root"
			group "root"
			mode "0755"
			path "name"
			recursive false
		end

		directory "/home/waseemtest" do
			owner "waz"
			group "sftpusers"
			mode "0755"
			path "name"
			recursive true
		end
		
		directory "/home/waseemtest" do
			owner "root"
			group "sftpusers"
			mode "0770"
			path "name"
			recursive false
		end

		mount "/home/waseemtest/public_html" do
			action [:mount, :enable]
			mount_point "/var/www/html"
			options "bind, rw"
		end
		
		
end	