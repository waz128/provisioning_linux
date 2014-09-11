include_recipe "os-hardening"

do "security" : {
  "kernel" : {
    "enable_module_loading" : true
  }
}
end
