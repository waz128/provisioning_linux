CHARS = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
def random_password(length=10)
	CHARS.sort_by { rand }.join[0...length]
end

file "/tmp/mysqlrootpass.txt" do
	action :create
	owner "root"
	group "root"
	mode "0644"
	content "#{random_password}"
end

node.set['mysql']['server_root_password'] = '#{random_password}'
node.set['mysql']['port'] = '3308'
node.set['mysql']['data_dir'] = '/data'

include_recipe 'mysql::server'

template '/etc/mysql/conf.d/mysite.cnf' do
  owner 'mysql'
  owner 'mysql'      
  source 'mysite.cnf.erb'
  notifies :restart, 'mysql_service[default]'
end