#
# Cookbook Name:: wordpress
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
package "php55" do
	action :install
end

service "httpd" do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end

remote_file "wordpress-4.0-en_CA.tar.gz" do
  mode "0644"
  source "http://en-ca.wordpress.org/wordpress-4.0-en_CA.tar.gz"
  checksum "sha256checksum"
end

bash "wordpress-4.0-en_CA.tar.gz" do
	user "root"
	cwd "/var/www/html"
	code <<-EOH
	tar -zxvf tar -zxvf data.tar.gz
	EOH
end

