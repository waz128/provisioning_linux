include_recipe "os-hardening"

"desktop" {enable = false} end

"security" {kernel:enable_module_loading = true} end
