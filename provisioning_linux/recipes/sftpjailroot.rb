include_recipe "conf"

#Generate random  password
randompass = (0...32).map{65.+(rand(25)).chr}.join
$pass = "#{randompass}"

sftpuser = "waseem"

if platform_family?("centos", "rhel")

	bash "savesftppass" do
			user "root"
			cwd "/tmp"
			code <<-EOH
			echo '#{randompass}' > /tmp/sftpuserpass.txt
			EOH
		end
		
		user "#{sftpuser}" do
			action :create
			supports :manage_home => true
			system true
			comment "Jail Root sFTP user"
			home "/home/#{sftpuser}"
			shell "/sbin/nologin"
			password "#{randompass}" 
		end

			group "sftpusers" do
			system true
			action :create
			members ['$sftpuser','apache']
		end

		directory "/home/#{sftpuser}/public_html/" do
			action :create
			owner "'#{sftpuser}'"
			group "sftpusers"
			mode "0755"
		end

		directory "/home/#{sftpuser}" do
			owner "#{sftpuser}"
			group "sftpusers"
			mode "0755"
			recursive true
		end
		
		directory "/home/#{sftpuser}" do
			owner "root"
			group "sftpusers"
			mode "0775"
			recursive false
		end

		conf_plain_file '/etc/ssh/sshd_config' do
		  current_line 'Subsystem sftp  /usr/libexec/openssh/sftp-server'
		  #pattern		/(Subsystem sftp \/usr\/libexec\/openssh\/sftp-server)/ 
		  new_line 'Subsystem sftp internal-sftp'
		  action :replace
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
		  new_line 	'Match User #{sftpuser}
   ChrootDirectory %h
   ForceCommand internal-sftp
   PasswordAuthentication yes'
		  action :append
		end

		mount "/var/www/html" do
			action [:mount, :enable]
			device "/home/#{sftpuser}/public_html"
			fstype "none"
			options "bind"
		end

end	