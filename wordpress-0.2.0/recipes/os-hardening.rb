#include_attribute "wordpress.0.2.0::os-hardening"
node.override['desktop']['enable'] = true
node.override['network']['forwarding'] = true
default['network']['ipv6']['enable'] = true
default['network']['arp']['restricted'] = true


include_recipe "os-hardening"

