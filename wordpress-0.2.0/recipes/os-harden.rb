include_attribute "wordpress.0.2.0::os-hardening"
include_recipe "os-hardening"

node.default['desktop']['enable'] = false
