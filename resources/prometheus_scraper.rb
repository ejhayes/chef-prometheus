resource_name :prometheus_scraper
provides :prometheus_scraper

property :scrape_interval, String, required: true, default: '5s'
property :targets, Array, required: true 

action :create do
    Chef::Log.info "Adding configuration for #{cookbook_name}"
    with_run_context :root do
        edit_resource(:template, node['prometheus']['prometheus']['config_file']) do |new_resource|
            self.cookbook_name = 'prometheus'
            source 'prometheus.yml.erb'
            variables[:scrapers] ||= []
            variables[:scrapers].push({
                job_name: new_resource.name,
                scrape_interval: new_resource.scrape_interval,
                targets: new_resource.targets
            })

            action :nothing
            delayed_action :create
            notifies :restart, 'service[prometheus]', :delayed
        end
    end
end