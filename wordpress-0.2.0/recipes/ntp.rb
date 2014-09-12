# Configure network time sync
include_recipe "ntp"

# Set system timezone - Default is Australia/Brisbane
case node[:platform]
  	when "ubuntu", "debian"
		execute "update-tzdata" do
			command "dpkg-reconfigure -f noninteractive tzdata"
			action :nothing
		end

		file "/etc/timezone" do
			owner "root"
			group "root"
			mode "00644"
			content node[:timezone]
  			notifies :run, "execute[update-tzdata]"
		end

		package "tzdata" do
			action :install
		end
  	when "amazon", "centos", "redhat", "fedora"
		link "/etc/localtime" do
  			to "/usr/share/zoneinfo/#{node[:timezone]}"
		end

		template "/etc/sysconfig/clock" do
			source "clock.erb"
		end
end

# Logrotate
include_recipe "logrotate"

# Re-Write /etc/rc.local file
template "/etc/rc.local" do
	source "rc.local.erb"
	mode 0755
	owner 'root'
	group 'root'
	manage_symlink_source true
	variables({
		:rc_local_commands => node[:melbit_linux][:rc_local_commands]
	})
end