#Generate random  password
randompass = (0...32).map{65.+(rand(25)).chr}.join
$pass = "#{randompass}"

if platform_family?("centos", "rhel")

		user "waseemtest" do
			action :create
			supports :manage_home => true
			system true
			comment "Jail Root sFTP user"
			home '/home/%u'
			shell "/sbin/nologin"
			password "#{randompass}" 
		end

			group "sftpusers" do
			system true
			action :create
			members ['waseemtest']
		end

end	