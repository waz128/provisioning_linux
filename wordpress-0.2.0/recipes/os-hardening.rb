#include_attribute "wordpress.0.2.0::os-hardening"
node.override['desktop']['enable'] = true
node.override['network']['forwarding'] = true
node.override['network']['ipv6']['enable'] = true
node.override['network']['arp']['restricted'] = true


include_recipe "os-hardening"

