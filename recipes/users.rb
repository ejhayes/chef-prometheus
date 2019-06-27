# Define prometheus group
group node[cookbook_name]['prometheus']['user'] do
  system true
end

# Define prometheus user
user node[cookbook_name]['prometheus']['user'] do
  comment 'prometheus service account'
  group node[cookbook_name]['prometheus']['user']
  system true
  shell '/bin/false'
end

# Define node_exporter group
group node[cookbook_name]['node_exporter']['user'] do
  system true
end

# Define node_exporter user
user node[cookbook_name]['node_exporter']['user'] do
  comment 'node_exporter service account'
  group node[cookbook_name]['node_exporter']['user']
  system true
  shell '/bin/false'
end
