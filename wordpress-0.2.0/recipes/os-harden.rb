include_recipe "os-hardening"

{
"chef_type": "role"
"json_class": "Chef::Role",
"security" : {
  "kernel" : {
    "enable_module_loading" : true
  }
}
},



