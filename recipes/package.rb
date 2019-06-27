
# setup dirs
directory node[cookbook_name]['prometheus']['install_dir'] do
  owner node[cookbook_name]['prometheus']['user']
  group node[cookbook_name]['prometheus']['user']
  mode '0755'
  action :create
end

directory node[cookbook_name]['prometheus']['data_dir'] do
  owner node[cookbook_name]['prometheus']['user']
  group node[cookbook_name]['prometheus']['user']
  mode '0755'
  action :create
end

# get prometheus
remote_file "/tmp/prometheus-#{node[cookbook_name]['prometheus']['version']}.linux-amd64.tar.gz" do
  source "#{node[cookbook_name]['prometheus']['github_url']}/releases/download/v#{node[cookbook_name]['prometheus']['version']}/prometheus-#{node[cookbook_name]['prometheus']['version']}.linux-amd64.tar.gz"
  owner 'root'
  group 'root'
  mode 0755
  only_if { ! File.exists? "#{node[cookbook_name]['prometheus']['bin_dir']}/prometheus" }
end

# extract prometheus
execute "Extract prometheus" do
  command "tar xvf prometheus-#{node[cookbook_name]['prometheus']['version']}.linux-amd64.tar.gz && cd prometheus-#{node[cookbook_name]['prometheus']['version']}.linux-amd64 && chown -R #{node[cookbook_name]['prometheus']['user']}:#{node[cookbook_name]['prometheus']['user']} . && mv promtool #{node[cookbook_name]['prometheus']['bin_dir']} && mv prometheus #{node[cookbook_name]['prometheus']['bin_dir']} && mv consoles #{node[cookbook_name]['prometheus']['install_dir']} && mv console_libraries #{node[cookbook_name]['prometheus']['install_dir']}"
  creates "#{node[cookbook_name]['prometheus']['bin_dir']}/prometheus"
  cwd "/tmp"
  only_if { ! File.exists? "#{node[cookbook_name]['prometheus']['bin_dir']}/prometheus" }
end


# get node_exporter
remote_file "/tmp/node_exporter-#{node[cookbook_name]['node_exporter']['version']}.linux-amd64.tar.gz" do
  source "#{node[cookbook_name]['node_exporter']['github_url']}/releases/download/v#{node[cookbook_name]['node_exporter']['version']}/node_exporter-#{node[cookbook_name]['node_exporter']['version']}.linux-amd64.tar.gz"
  owner 'root'
  group 'root'
  only_if { ! File.exists? "#{node[cookbook_name]['node_exporter']['bin_dir']}/node_exporter" }
end

execute "Extract node_exporter" do 
  command "tar xvf node_exporter-#{node[cookbook_name]['node_exporter']['version']}.linux-amd64.tar.gz && cd node_exporter-#{node[cookbook_name]['node_exporter']['version']}.linux-amd64 && chown -R #{node[cookbook_name]['node_exporter']['user']}:#{node[cookbook_name]['node_exporter']['user']} . && mv node_exporter #{node[cookbook_name]['node_exporter']['bin_dir']}"
  creates "#{node[cookbook_name]['node_exporter']['bin_dir']}/node_exporter"
  cwd "/tmp"
  only_if { ! File.exists? "#{node[cookbook_name]['node_exporter']['bin_dir']}/node_exporter" }
end
