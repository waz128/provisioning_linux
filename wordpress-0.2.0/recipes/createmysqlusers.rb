include_recipe "database::mysql"

# Create a mysql database
mysql_database 'wordpress' do
  connection(
    :host     => 'localhost',
    :username => 'waz01',
    :password => node['mysql']['server_root_password']
  )
  action :create
end