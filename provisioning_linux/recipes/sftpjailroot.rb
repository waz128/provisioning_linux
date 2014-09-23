#Generate random  password
randompass = (0...32).map{65.+(rand(25)).chr}.join
$pass = "#{randompass}"

if platform_family?("centos", "rhel")

		group "sftpuseers" do
			action :create
			members ['#{randomuser}']
		end

		user "waseemtest" do
			action :create
			system true
			comment "Jail Root sFTP user"
			home "/home/%u"
			shell "/sbin/nologin"
			password "#{randompass}"
			supports :manage_home => true 
		end

end	