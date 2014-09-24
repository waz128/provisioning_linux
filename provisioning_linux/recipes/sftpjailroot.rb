#Generate random  password
randompass = (0...32).map{65.+(rand(25)).chr}.join
$pass = "#{randompass}"

if platform_family?("centos", "rhel")

	bash "savesftppass" do
			user "root"
			cwd "/tmp"
			code <<-EOH
			echo '#{randompass}' > /tmp/sftpuserpass.txt
			EOH
		end

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

		directory "/home/waseemtest/public_html/" do
			action :create
			owner "waseemtest"
			group "sftpusers"
			mode "0755"
		end

		directory "/home/waseemtest" do
			owner "waseemtest"
			group "sftpusers"
			mode "0755"
			recursive true
		end
		
		directory "/home/waseemtest" do
			owner "root"
			group "sftpusers"
			mode "0775"
			recursive false
		end

		ruby_block "update sshd config" do
			block do
				file = Chef::Util::FileEdit.new("/etc/ssh/sshd_config")
				file.search_file_replace_line("/Subsystem sftp /usrlibexec/openssh/sftp-server/", "Subsystem/sftp/internal-sftp1")
    			file.write_file
			end
		end
		
		ruby_block "reload client config" do
			block do
				Chef::Config.from_file("/etc/chef/client.rb")
			end
		end
		

		mount "/var/www/html" do
			action [:mount, :enable]
			device "/home/waseemtest/public_html"
			fstype "none"
			options "bind"
		end



end	