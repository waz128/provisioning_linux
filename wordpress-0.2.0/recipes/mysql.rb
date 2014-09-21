include_recipe "database::mysql"

mysqlroot = (0...32).map{65.+(rand(25)).chr}.join
node.override['mysql']['server_root_password'] = "#{mysqlroot}"

mysqluser = (0...32).map{65.+(rand(25)).chr}.join
node.override['mysql']['server_user_password'] = "#{mysqluser}"

if platform_family?("centos", "rhel")
  
    #Install mysql server to the latest version
    package "mysql-server" do
      action :install
    end

    #Start mysql service
    service "mysqld" do
      supports :status => true, :restart => true, :reload => true
      action [:start ]
    end
    
    # Set a mySQL root password and output it to a text file under /tmp/mysqlrootpassword.txt
    execute "assign-root-password" do
      action :run
      command "/usr/bin/mysqladmin -u root password '#{mysqlroot}' ; echo '#{mysqlroot}' > /tmp/mysqrootpassword.txt"
    end

    # Externalize conection info in a ruby hash
    mysql_connection_info = {
      :host     => 'localhost',
      :username => 'root',
      :password => node['mysql']['server_root_password']
    }

    mysql_database_user '' do
    connection mysql_connection_info
    action     :drop
    end

    # Create a mysql database
    mysql_database 'wordpress' do
      connection(
        :host     => 'localhost',
        :username => 'root',
        :password => node['mysql']['server_root_password']
      )
      action :create
    end

    #Create a mysql user
    mysql_database_user 'wordpress_prod' do
      connection mysql_connection_info
      password      node['mysql']['server_user_password'] 
      database_name 'wordpress'
      host          'localhost'
      privileges    [:select,:insert,:update,:delete,:create,:drop,:references,:index,:alter,:'create temporary tables',:'lock tables',:execute,:'create view',:'show view',:'create routine',:'alter routine',:trigger]
      action        [:create, :grant]
    end

    #Create a mysql user
    mysql_database_user 'wordpress_prod' do
      connection mysql_connection_info
      password      node['mysql']['server_user_password'] 
      database_name 'wordpress'
      host          '%'
      privileges    [:select,:insert,:update,:delete,:create,:drop,:references,:index,:alter,:'create temporary tables',:'lock tables',:execute,:'create view',:'show view',:'create routine',:'alter routine',:trigger]
      action        [:create, :grant]
    end

    #Set mysql service to enabled status, in the event server is rebooted
    service "mysqld" do
      supports :status => true, :restart => true, :reload => true
      action [:enable]
    end

    execute "save-mysqluserpass" do
      action :run
      command "echo '#{mysqluser}' > /tmp/mysqluserpassword.txt"
    end
    
end