#
# Cookbook:: mariadb
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
node['mariadb']['server']['packages'].each do |name|
package name  do 
 action :install
end
end
service 'mariadb' do
action [:enable, :start]
end
template '/etc/config.sql' do
  source 'config.sql.erb'
  owner  'root'
  group  'root'
  mode   '0600'
  action :create
end
execute 'install-scripts' do
  command 'mysql </etc/config.sql'
  notifies :restart, 'service[mariadb]', :immediately
end

