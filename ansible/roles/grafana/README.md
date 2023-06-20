# Ansible Role: Grafana

This Ansible role installs and configures Grafana on a target system.

## Requirements

- The target system must be running a supported Linux distribution.

## Role Variables

The following variables can be customized in the `defaults/main.yml` file:

| Variable                              | Description                                     | Default                      |
|---------------------------------------|-------------------------------------------------|------------------------------|
| `grafana_admin_password`              | Password for the Grafana admin user              | "abc1234"                    |
| `grafana_datasource_dir_configuration`| Directory for Grafana datasources configuration  | "/etc/grafana/provisioning/datasources" |
| `grafana_dashboard_dir_configuration` | Directory for Grafana dashboards configuration   | "/etc/grafana/provisioning/dashboards"  |

## Dependencies

None.

## Example Playbook

```yaml
- name: Install and configure Grafana
  hosts: servers
  roles:
    - role: grafana