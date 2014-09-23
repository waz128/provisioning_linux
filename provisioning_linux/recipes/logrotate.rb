include_recipe "logrotate"

logrotate_app 'httpd' do
  cookbook  'logrotate'
  path      '/var/log/httpd/'
  options   ['missingok', 'delaycompress', 'notifempty']
  frequency 'weekly'
  rotate    30
end

logrotate_app 'logs' do
  cookbook  'logrotate'
  path      '/var/log/'
  options   ['missingok', 'delaycompress', 'notifempty']
  frequency 'weekly'
  rotate    30
end