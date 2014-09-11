include_recipe "os-hardening"

"desktop" {
    "enable" :false
},

"security" {
  "kernel" {
    "enable_module_loading" :true
  }
},