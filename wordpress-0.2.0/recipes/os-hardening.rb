node.override['desktop']['enable'] = false
node.override['network']['forwarding'] = false
node.override['network']['ipv6']['enable'] = false
node.override['network']['arp']['restricted'] = false
node.override['env']['umask'] = "027"
node.override['env']['root_path'] = "/"
node.override['auth']['pw_max_age'] = 90
node.override['auth']['pw_min_age'] = 7
node.override['auth']['retries'] = 5
node.override['auth']['lockout_time'] = 600
node.override['auth']['timeout'] = 60
node.override['auth']['allow_homeless'] = true
node.override['auth']['pam']['passwdqc']['enable'] = false
node.override['security']['kernel']['enable_module_loading'] = true
node.override['security']['kernel']['enable_sysrq'] = false
node.override['security']['kernel']['enable_core_dump'] = false
node.override['security']['suid_sgid']['enforce'] = false
node.override['security']['packages']['clean'] = true

include_recipe "os-hardening"

