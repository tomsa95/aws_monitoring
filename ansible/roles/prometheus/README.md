Ansible Role: prometheus
========================

A role to install and configure Prometheus monitoring system.

Defaults
--------

The role includes the following default variables:

| Variable                            | Default Value          |
|-------------------------------------|------------------------|
| `prometheus_dir_configuration`      | `/etc/prometheus`      |
| `prometheus_retention_time`         | `365d`                 |
| `prometheus_scrape_interval`        | `30s`                  |
| `prometheus_node_exporter`          | `true`                 |
| `prometheus_node_exporter_group`    | `tag_Name_client`      |
| `prometheus_env`                    | `production`           |
| `prometheus_var_config`             |                        |
| `prometheus_var_config.global`      |                        |
| `prometheus_var_config.scrape_configs`  |                     |

Note: The `prometheus_var_config` variable is a dictionary containing the global and scrape configurations for Prometheus. The values for `prometheus_var_config.global` and `prometheus_var_config.scrape_configs` need to be defined separately in your playbook or inventory.

Tasks
-----

The role consists of the following tasks:

1. Update and install Prometheus:
   - Uses the `apt` module to install the latest version of Prometheus.
   - Updates the package cache before installation.
   - Caches the package list for 1 hour.

2. Configure Prometheus arguments:
   - Uses the `template` module to generate the Prometheus arguments configuration file (`prometheus.j2`).
   - Sets the source template to `prometheus.j2`.
   - Sets the destination path to `/etc/default/prometheus`.
   - Sets the file permissions to `0644` with root as the owner and group.
   - Notifies the `restart_prometheus` handler.

3. Configure Prometheus main configuration file:
   - Uses the `template` module to generate the Prometheus main configuration file (`prometheus.yaml.j2`).
   - Sets the source template to `prometheus.yaml.j2`.
   - Sets the destination path to `{{ prometheus_dir_configuration }}/prometheus.yml`.
   - Sets the file permissions to `0755` with `prometheus` as the owner and group.
   - Notifies the `reload_prometheus` handler.

4. Start Prometheus service:
   - Uses the `systemd` module to start the Prometheus service.
   - Sets the service name to `prometheus`.
   - Sets the state to `started`.
   - Enables the service to start on boot.

Templates
---------

The role includes the following templates:

1. `prometheus.j2`:
   - Arguments configuration template for Prometheus.
   - Contains the following variables:
     - `prometheus_retention_time`: Retention time for Prometheus data.

2. `prometheus.yaml.j2`:
   - Main configuration file template for Prometheus.
   - Contains the following variables:
     - `prometheus_var_config`: Prometheus configuration settings.
     - `prometheus_node_exporter_group`: Group name for Prometheus node exporters.
