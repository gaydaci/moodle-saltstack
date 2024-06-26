add-apt-repository ppa:ondrej/php -y:
  cmd.run

install_php_8:
  pkg.installed:
    - pkgs:
      - graphviz 
      - aspell 
      - ghostscript 
      - clamav
      - php8.0-fpm
      - php8.0-cli
      - php8.0-pspell
      - php8.0-curl 
      - php8.0-gd 
      - php8.0-intl
      - php8.0-pgsql
      - php8.0-xml
      - php8.0-xmlrpc
      - php8.0-ldap
      - php8.0-zip
      - php8.0-soap
      - php8.0-mbstring

# Set max_input_vars to more than 5000 in php.ini
adjust_max_input_vars:
  file.replace:
    - name: '/etc/php/8.0/fpm/php.ini'
    - pattern: ';?\s*(max_input_vars\s*=\s*)\d+'
    - repl: '\1 6000'

restart_phpfpm_service:
  # Workaround to force service.running to restart the service.
  test.succeed_with_changes:
    - watch_in:
      - service: restart_phpfpm_service
  service.running:
    - name: php8.0-fpm
    - enable: True
    - full_restart: True
