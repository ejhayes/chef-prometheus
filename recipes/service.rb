template '/etc/systemd/system/prometheus.service' do
  source 'prometheus.service.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, "service[prometheus]", :delayed
end

template '/etc/systemd/system/node_exporter.service' do
  source 'node_exporter.service.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, "service[node_exporter]", :delayed
end

service 'prometheus' do
  provider Chef::Provider::Service::Systemd
  supports status: true
  action [:enable, :start]
end

service 'node_exporter' do
  provider Chef::Provider::Service::Systemd
  supports status: true
  action [:enable, :start]
end
