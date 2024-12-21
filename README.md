# Inception

Inception is a system administration project that focuses on building a containerized web infrastructure using Docker. It sets up and secures services like NGINX, WordPress, and MariaDB, creating custom Docker images and ensuring communication via a dedicated network. This project emphasizes best practices, security, and hands-on learning of essential DevOps skills.

![inception map](/public/inception.jpg)

## Docker Images and Containers

- **Docker Images**: Blueprints containing the software, dependencies, and configurations needed to create containers.

- **Docker Containers**: Running instances of Docker images that provide isolated environments for applications.

In this project, images are built for NGINX, WordPress, and MariaDB, and containers based on these images run the services.

## Docker-compose

Docker Compose is a tool that simplifies the management of multi-container Docker applications. It uses a docker-compose.yml file to define and manage the services, networks, and volumes required for the application. With a single command, you can build, start, and manage all containers.

### Overview of docker-compose.yml

The docker-compose.yml defines a web infrastructure with three services—NGINX, WordPress, and MariaDB:

**Volumes**:

- Custom local directories are mapped for persistent storage of WordPress files and the MariaDB database. This ensures data can be accessed even if containers are recreated.

- These directories are mounted using the driver_opts configuration with the bind option.

**Networks**:

A custom bridge network named inception facilitates secure communication between containers while isolating them from external networks.

**Services**:

- **NGINX**: Acts as the entry point, handling HTTPS traffic (port 443) and routing it to WordPress. It uses a volume to serve WordPress files and is configured to restart automatically.

- **WordPress**: Hosts the website, relying on MariaDB for database services. It shares a volume with NGINX for file synchronization.

- **MariaDB**: Manages the database backend for WordPress, with a dedicated volume for storing database data securely.

## NGINX Dockerfile

This Dockerfile creates a custom NGINX image for serving secure web traffic. Key steps include:

- **Base Image**: Uses alpine:3.19.4 for a lightweight and secure base.
- **Dependencies**: Installs NGINX and OpenSSL.

- **SSL Configuration**: Generates an SSL certificate and key stored in /etc/nginx/ssl.

- **User Setup**: Adds a restricted www-data user for better security.

- **Configuration**: Copies a custom nginx.conf file into the container.

- **Expose Port**: Exposes port 443 for HTTPS.

- **CMD**: Runs NGINX in the foreground with the provided configuration.

## Wordpress Dockerfile

This Dockerfile builds a custom WordPress PHP-FPM container. Key steps include:

- **Base Image**: Starts with alpine:3.19.4 for a lightweight foundation.

- **User and Group Setup**: Creates a dedicated nginx user and group.

- **Dependencies**: Installs PHP 8.1 modules required for WordPress and the MariaDB client.

- **Directory Setup**: Prepares directories for PHP-FPM and WordPress files.

- **Configuration**: Copies a custom PHP-FPM configuration file (www.conf).

- **Expose Port**: Opens port 9000 for PHP-FPM.

- **Script Integration**: Copies and sets executable permissions for a startup script (script.sh).

- **CMD**: Executes the startup script via ENTRYPOINT.

This container serves as the backend for WordPress, handling PHP processing.

## MariaDB Dockerfile

This Dockerfile creates a custom MariaDB container. Key steps include:

- **Base Image**: Uses alpine:3.19.4 for a minimal and secure base.

- **Dependencies**: Installs MariaDB and its client tools.

- **Configuration**: Copies a custom MariaDB configuration file (mariadb-server.cnf) for server settings.

- **Expose Port**: Opens port 3306 for database connections.

- **Script Integration**: Copies and sets executable permissions for an initialization script (script.sh).

- **Command**: Runs the initialization script via ENTRYPOINT.

This container provides the database backend for WordPress with MariaDB.