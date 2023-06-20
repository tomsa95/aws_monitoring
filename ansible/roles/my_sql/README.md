# Ansible Role: MySQL

An Ansible role for installing and configuring MySQL, creating databases, and managing users for WordPress.

## Requirements

None.

## Role Variables

The following table lists the customizable variables and their default values. These variables can be modified in the `defaults/main.yaml` file.

| Variable                 | Default Value | Description                             |
|--------------------------|---------------|-----------------------------------------|
| `mysql_user`             | `wordpress`   | The MySQL user for WordPress.            |
| `mysql_password`         | `password`    | The password for the MySQL user.         |
| `mysql_db`               | `wordpress`   | The name of the database for WordPress.  |
| `mysql_root_password`    | `sudopass`    | The password for the MySQL root user.    |

## Dependencies

None.

## Example Playbook

```yaml
- name: Install and configure MySQL for WordPress
  hosts: database
  roles:
    - role: mysql