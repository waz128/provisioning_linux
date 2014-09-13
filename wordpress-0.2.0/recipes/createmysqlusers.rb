api_string = (0...32).map{65.+(rand(25)).chr}.join
$mypass = "#{api_string}"

print  #{api_string}
print  #{api_string}

mysql_database 'wordpress' do
	connection(
			:username => 'root',
			:password => node['mysql']['#{api_string}']
	)