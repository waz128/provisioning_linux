# NTP Settings
default[:ntp][:servers] = [ "0.amazon.pool.ntp.org", "1.amazon.pool.ntp.org", "2.amazon.pool.ntp.org", "3.amazon.pool.ntp.org" ]

# Timezone Settings
default[:timezone] = "Australia/Brisbane"

# /etc/rc.local Additional Commands to run
default[:wordpress-0.2.0][:rc_local_commands] = []


