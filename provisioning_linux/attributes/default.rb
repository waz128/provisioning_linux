# Cookbook Name:: melbit_linux
# Attributes:: default
#
# Copyright 2013, Melbourne IT Enterprise Services
#
# All rights reserved - Do Not Redistribute
#

# NTP Settings
default[:ntp][:servers] = [ "0.amazon.pool.ntp.org", "1.amazon.pool.ntp.org", "2.amazon.pool.ntp.org", "3.amazon.pool.ntp.org" ]

# Timezone Settings
default[:timezone] = "Australia/Brisbane"

# /etc/rc.local Additional Commands to run
default[:melbit_linux][:rc_local_commands] = []


