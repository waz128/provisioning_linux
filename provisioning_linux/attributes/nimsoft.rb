# Cookbook Name:: melbit_linux
# Attributes:: nimsoft 
#
# Copyright 2013, Melbourne IT Enterprise Services
#
# All rights reserved - Do Not Redistribute
#

# Nimsoft Configuration 
#
# Default AWS Hub is:
#
# Hub Name = AMZ-AGRHUB2
# Hub IP = 54.252.177.16
#
# Staging Hub is:
#
# Hub Name = BNE3-StagingHub
# Hub IP = 210.247.233.40
#

default[:nimsoft][:packages] = "_AWS_Linux"
default[:nimsoft][:robotname] = node["$INSTANCE_ID"][:instance_id]
default[:nimsoft][:robotip] = node["$INSTANCE_ID"][:local_ipv4]
default[:nimsoft][:robotaliasip] = node["$INSTANCE_ID"][:public_ipv4]

# Aggregation Hub your robot is connecting to.
case node[:ec2][:placement_availability_zone]
	when "ap-southeast-2a"
		default[:nimsoft][:hub1ip] = "54.252.177.16"
		default[:nimsoft][:hub1name] = "AMZ-AGRHUB2"
		default[:nimsoft][:hub1robotname] = "amz-0002nms"

		default[:nimsoft][:hub2ip] = "54.252.177.4"
		default[:nimsoft][:hub2name] = "AMZ-AGRHUB3"
		default[:nimsoft][:hub2robotname] = "amz-0003nms"
	when "ap-southeast-2b"
		default[:nimsoft][:hub1ip] = "54.252.177.4"
		default[:nimsoft][:hub1name] = "AMZ-AGRHUB3"
		default[:nimsoft][:hub1robotname] = "amz-0003nms"

		default[:nimsoft][:hub2ip] = "54.252.177.16"
		default[:nimsoft][:hub2name] = "AMZ-AGRHUB2"
		default[:nimsoft][:hub2robotname] = "amz-0002nms"
	else
                default[:nimsoft][:hub1ip] = "54.252.177.16"
                default[:nimsoft][:hub1name] = "AMZ-AGRHUB2"
                default[:nimsoft][:hub1robotname] = "amz-0002nms"

                default[:nimsoft][:hub2ip] = "54.252.177.4"
                default[:nimsoft][:hub2name] = "AMZ-AGRHUB3"
                default[:nimsoft][:hub2robotname] = "amz-0003nms"
end

