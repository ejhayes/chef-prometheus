# prometheus configuration
template node[cookbook_name]['prometheus']['config_file'] do
    source 'prometheus.yml.erb'
    mode '0644'
    action :create
    notifies :restart, 'service[prometheus]', :delayed
end