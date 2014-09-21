# Cookbook Name:: melbit_linux
# Attributes:: users
#
# Copyright 2013, Melbourne IT Enterprise Services
#
# All rights reserved - Do Not Redistribute
#


# enable SSH Agent Forwarding
default[:openssh][:client][:forward_agent] = "yes"

# configure SSH Server
default[:openssh][:server][:password_authentication] = "no"
default[:openssh][:server][:challenge_response_authentication] ="no"
default[:openssh][:server][:use_p_a_m] = "yes"
default[:openssh][:server][:x11_forwarding] = "yes"
default[:openssh][:server][:print_lastlog] = "yes"
default[:openssh][:server][:syslog_facility] = "AUTHPRIV"

# Enforce SSH Protocol version 2 only on the server - SSH Protocol 1 has security vulnerabilities (CVE-2001-1473)
default[:openssh][:server][:protocol] = "2"

# default attributes for users cookbook
default[:melbit_linux][:customer_users] = ""
default[:melbit_linux][:customer_admins] = ""

# add melbit_admins and custadmins to sudoers
default[:authorization][:sudo][:groups] = [ "melbit-admins", "customer-admins" ]
default[:authorization][:sudo][:passwordless] = true
#default[:authorization][:sudo][:include_sudoers_d] = true
case platform
  when "amazon"
    default[:authorization][:sudo][:users] = [ "ec2-user" ]
  when "redhat", "centos"
    default[:authorization][:sudo][:users] = [ "root" ]
  when "ubuntu"
    default[:authorization][:sudo][:users] = [ "ubuntu" ]
end
