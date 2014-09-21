# Stop the IPtables service. Good to instances within AWS with Security Groups and ACL's in a VPC.
service 'iptables' do
  action [ :disable, :stop ]
end