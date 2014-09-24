include_recipe "conf"


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


		conf_plain_file '/etc/ssh/sshd_config' do
		  pattern		/(Subsystem sftp)  \/usr\/libexec\/openssh\/sftp-server/ 
		  new_line 		'Subsystem sftp internal-sftp'
		  action :insert_after_match
		end

		conf_plain_file '/etc/ssh/sshd_config' do
		  #pattern		/Subsystem sftp  \/usr\/libexec\/openssh\/sftp-server/ 
		  new_line 	'Match Group sftpusers
	ChrootDirectory %h
	ForceCommand internal-sftp
	AllowTcpForwarding no
	X11Forwarding no '
		  action :append
		end

		conf_plain_file '/etc/ssh/sshd_config' do
		  #pattern		/Subsystem sftp  \/usr\/libexec\/openssh\/sftp-server/ 
		  new_line 	'Match User waz
   ChrootDirectory %h
   ForceCommand internal-sftp
   PasswordAuthentication yes'
		  action :append
		end



		mount "/var/www/html" do
			action [:mount, :enable]
			device "/home/waseemtest/public_html"
			fstype "none"
			options "bind"
		end

end	