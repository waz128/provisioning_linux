#
# Cookbook Name:: melbit_linux
# Recipe:: nimsoft
#
# Copyright 2013, Melbourne IT Enterprise Services
#
# All rights reserved - Do Not Redistribute
#

# Create Nimsoft folders
directory "/opt/nimsoft/tmp" do
 recursive true
 action :create
end

# Download Nimsoft binaries from S3
remote_file "/opt/nimsoft/tmp/install_LINUX_23_64.zip" do
  source "https://s3-ap-southeast-2.amazonaws.com/melbourneit-public/nimsoft/linux/install_LINUX_23_64.zip"
  checksum "2c38322b4162f0af50af05f3a8a4690a"
  mode 00400
  action :create_if_missing
end

remote_file "#{Chef::Config[:file_cache_path]}/nimldr.tar.z" do
  source "https://s3-ap-southeast-2.amazonaws.com/melbourneit-public/nimsoft/linux/nimldr.tar.z"
  checksum "4541eb0d8e883d8c73a1bc16c94eadbd"
  mode 00400
  action :create_if_missing
end

# Extract Nimsoft Binaries
bash "extract_nimsoft" do
  user "root"
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar -zxf nimldr.tar.z
  EOH
  not_if { File.exists?("#{Chef::Config[:file_cache_path]}/nimldr/README") }
end

# Install Nimsoft
bash "install_nimsoft" do
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}/nimldr/LINUX_23_64"
  code <<-EOH
  ./nimldr -E -a -t /opt/nimsoft/tmp -F /opt/nimsoft/tmp -o 48000 -N #{node[:nimsoft][:robotname]} -D MelbourneIT -I #{node[:nimsoft][:hub1ip]} -H #{node[:nimsoft][:hub1name]} -R #{node[:nimsoft][:robotip]}
  EOH
  not_if { File.exists?("/opt/nimsoft/robot/spooler.cfg") }
end

service "nimbus" do
  provider Chef::Provider::Service::Upstart
  supports :restart => true, :reload => true
  subscribes :reload, "template[/opt/nimsoft/robot/robot.cfg]", :immediately
end

# Add Nimsoft Configuration Files
template "/opt/nimsoft/request.cfg" do
  source "request.cfg.erb"
  mode 00400
  owner "root"
  not_if { File.exists?("/opt/nimsoft/.installed") }
end

template "/opt/nimsoft/robot/robot.cfg" do
  source "robot.cfg.erb"
  mode 00644
  owner "root"
  not_if { File.exists?("/opt/nimsoft/.installed") }
end

# touch a file to confirm Nimsoft installed correctly so templates are not repushed
bash "confirm_nimsoft_install" do
  cwd "/opt/nimsoft"
  code <<-EOH
  touch /opt/nimsoft/.installed
  EOH
  not_if { File.exists?("/opt/nimsoft/.installed") }
end
