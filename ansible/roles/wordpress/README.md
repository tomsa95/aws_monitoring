# Ansible Role Documentation: wordpress

This Ansible role deploys and manages a WordPress application using Docker.

## Tasks

- **Start WordPress container**: Starts a Docker container for the WordPress application with the following configuration:
  
  ```yaml
  - name: Start WordPress container
    docker_container:
      name: wordpress_app
      image: wordpress:latest
      restart_policy: always
      ports:
        - "8080:80"
      env:
        WORDPRESS_DB_HOST: "{{ ansible_hostname }}:33060"
        WORDPRESS_DB_USER: "{{WP_DB_USER}}"
        WORDPRESS_DB_PASSWORD: "{{WP_DB_PASSWORD}}"
        WORDPRESS_DB_NAME: "{{WP_DB_NAME}}"
      state: started
    ```

## Default Variables

The following default variables are defined in the `defaults/main.yaml` file:

Variable          | Default Value
----------------- | -------------
WP_DB_USER        | wordpress
WP_DB_PASSWORD    | password
WP_DB_NAME        | wordpress

## Usage

To use this Ansible role, include it in your playbook's `roles` section:

```yaml
- name: Deploy WordPress
  hosts: your_target_hosts
  roles:
    - wordpress
```

You can override the default variables by specifying new values in your playbook:

```yaml
- name: Deploy WordPress
  hosts: your_target_hosts
  roles:
    - name: wordpress
      vars:
        WP_DB_USER: my_wp_user
        WP_DB_PASSWORD: my_wp_password
        WP_DB_NAME: my_wp_db
```
