# moodle-saltstack

## Description
**moodle-saltstack** is a set of SaltStack states designed for the automated installation and configuration of Moodle, an open-source learning management system. This project ensures a smooth and consistent deployment of Moodle with Nginx and PostgreSQL on Ubuntu 24.04 servers using Salt SSH .

## Installation
To install and set up Moodle using this SaltStack routine, follow these steps:

1. **Install SaltStack**:
Follow the [official SaltStack installation guide](https://docs.saltproject.io/salt/install-guide/en/latest/index.html) to install SaltStack on your local machine.
2. **Configure Salt SSH**:
Ensure [Salt SSH](https://docs.saltproject.io/en/latest/topics/ssh/index.html) is properly configured. You will need to configure the `roster` file to define the target servers. Example `roster` file:

```yaml
myserver:
  host: 192.168.0.1
  user: myuser
  passwd: mypassword
```
3. **Clone the Repository**:
   ```sh
   cd /srv/salt
   git clone https://github.com/gaydaci/moodle-saltstack.git
   cd moodle-saltstack
4. **Deploy on targets**:
   ```sh
   salt-ssh '*' state.apply

## States Structure
- **nginx**: Installs the Nginx web server.
- **php8**: Installs PHP version 8 and handles its configuration.
- **postgresql**: Installs and sets up the PostgreSQL database server. Creates user and database for Moodle.
- **moodle**: Manages the installation and configuration of the Moodle learning management system.
- **cfg_nginx**: Configures the Nginx server, with the simple configuration in [nginx/moodle.conf](nginx/moodle.conf).
- **letsencrypt**: Handles the generation and automatic installation of Let's Encrypt SSL certificates for Nginx using [certbot](https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal).
