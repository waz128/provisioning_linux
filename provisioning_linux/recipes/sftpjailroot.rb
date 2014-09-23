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

		directory "/home/waseemtest/" do
			owner "waseemtest"
			group "sftpusers"
			mode "0755"
			recursive true
		end
		
		directory "/home/waseemtest" do
			owner "root"
			group "sftpusers"
			mode "0775"
			path "name"
			recursive false
		end

		#directory "/home/waseemtest/public_html/" do
		#	action :create
		#	owner "waseemtest"
		#	group "sftpusers"
		#	mode "0755"
		#	recursive false
		#end

		%w[ /home /home/waseemtest /home/waseemtest/public_html ].each do |path|
		  directory path do
		    owner 'waseemtest'
		    group 'sftpusers'
		    mode '0755'
		  end
		end


		mount "/var/www/html" do
			action [:mount, :enable]
			device "/home/waseemtest/public_html"
			fstype "none"
			options "bind"
			end
		
		
end	