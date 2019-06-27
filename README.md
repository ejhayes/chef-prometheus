# Chef Prometheus
Supports setting up and configuring Prometheus (with optional `node_exporter` too) on Ubuntu 16.04. This probabaly works for other debian based distros too.


## Quickstart
To use this module:

    include_recipe prometheus::default

And if you want to add any scrapers (including the default one):

    prometheus_scraper 'prometheus' do
        scrape_interval '5s'
        targets ['localhost:9090']
    end

    prometheus_scraper 'node_exporter' do
        scrape '5s'
        targets ['localhost:9100']
    end

## Configuration
See configuration at [attributes](attributes/default.rb).