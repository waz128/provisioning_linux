# Cookbook Name:: melbit_linux
# Attributes:: jmeter
#
# Copyright 2013, Melbourne IT Enterprise Services
#
# All rights reserved - Do Not Redistribute
#

# JMeter Binaries
default[:jmeter][:file] = 'apache-jmeter-2.9.tgz'
default[:jmeter][:baseurl] = 'http://mirror.ventraip.net.au/apache//jmeter/binaries/'
default[:jmeter][:checksum] = 'e3554185a6a256dfc503e64255dfa3e7'
