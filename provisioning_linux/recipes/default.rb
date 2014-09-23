#
# Cookbook Name:: wordpress
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
include_recipe "chef-client::delete_validation"
include_recipe "chef-client"

#include_recipe "provisioning_linux::sophos"
#include_recipe "provisioning_linux::apache+wordpress" 
#include_recipe "provisioning_linux::mysql"
#include_recipe "provisioning_linux::os-hardening"
#include_recipe "provisioning_linux::timezone"
#include_recipe "provisioning_linux::logrotate"
#include_recipe "provisioning_linux::disableiptables"
include_recipe "provisioning_linux::nimsoft"
##include_recipe "provisioning_linux::sftp"