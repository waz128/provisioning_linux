include_recipe "os-hardening"

"security" => {
  "kernel" => {
    "enable_module_loading" => "true"
  }
},
