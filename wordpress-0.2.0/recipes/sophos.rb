

####
#
# Putting a hold on this until the new year. Awaiting HTTP endpoint
# Awaiting implementation of http://www.sophos.com/en-us/support/knowledgebase/38238.aspx
#
####
include_recipe "smbfs"

Create share directory
directory "/mnt/sophos-share" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

 Mount share
 depends on: https://github.com/realityforge/chef-smbfs
 include_recipe 'smbfs::attribute_driven'

install sophos
bash 'install-sophos' do
  code <<-EOH
#    /opt/sophos-share/CIDs/S002/savlinux/install.sh "/opt/sophos-av" install.sh --automatic --SavWebPassword= --enableSavProtectOnBoot=True --update-source-username=savaws --update-source-password="88837cm20ncmMNC-3&^@)C" --instdir=/opt/sophos-av --update-cache-path=/opt/sophos-av/update/cache/Primary --enableSavWeb=False --update-type=o --update-source-path=http://apse2-0001sec.aws.server-noc.com/SophosUpdate/CIDs/S008 --acceptlicence=True --SavWebUsername=admin --SavWebPort=8081 --enableRMS=true --automatic=True --enableOnAccess=true --update-period-minutes=60
#  EOH
  not_if { Dir.exists?('/opt/sophos-av') }
end