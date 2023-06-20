# Ansible Role: node-exporter

This Ansible role installs and configures the Prometheus Node Exporter on a target system.

## Role Variables

The following table lists the variables that can be customized to adjust the behavior of the role. These variables are defined in the `defaults/main.yaml` file.

| Variable                   | Default Value                      | Description                                        |
|----------------------------|------------------------------------|----------------------------------------------------|
| `node_exporter_version`    | `"1.1.2"`                          | The version of Node Exporter to install            |
| `node_exporter_bin`        | `/usr/local/bin/node_exporter`     | The path where the Node Exporter binary will be installed |
| `node_exporter_user`       | `node-exporter`                    | The user account under which Node Exporter will run |
| `node_exporter_group`      | `{{ node_exporter_user }}`         | The primary group of the Node Exporter user         |
| `node_exporter_dir_conf`   | `/etc/node_exporter`               | The directory path where Node Exporter's configuration files will be stored |

## Dependencies

None.

## Example Playbook

Here's an example playbook demonstrating how to use this role:

```yaml
- name: Install and configure Node Exporter
  hosts: servers
  roles:
    - role: node-exporter
```

## Role Tasks
The role performs the following tasks, defined in the tasks/main.yaml file:

1. Check if Node Exporter is already installed.
2. Create the Node Exporter user.
3. Create the Node Exporter configuration directory.
4. If Node Exporter is installed, retrieve its version.
5. If Node Exporter is not installed or the installed version does not match the desired version, download and install the specified version.
6. Clean up temporary files after installation.
7. Install the Node Exporter service.
8. Reload the systemd daemon and restart the Node Exporter service when the configuration changes.
9. Ensure the Node Exporter service is always started and enabled.

## Role Handlers
The role defines the following handler, specified in the handlers/main.yaml file:

```yaml
Copy code
- name: reload_daemon_and_restart_node_exporter
  systemd:
    name: node_exporter
    state: restarted
    daemon_reload: yes
    enabled: yes
```
## Role Templates
The role provides a template for the Node Exporter systemd service file, located at `templates/node_exporter.service.j2.` The template defines the following:

```ini
Copy code
[Unit]
Description=Node Exporter Version {{ node_exporter_version }}
After=network-online.target

[Service]
User={{ node_exporter_user }}
Group={{ node_exporter_user }}
Type=simple
ExecStart={{ node_exporter_bin }}

[Install]
WantedBy=multi-user.target
```
The node_exporter_version variable is used to populate the Description field in the systemd unit file.
