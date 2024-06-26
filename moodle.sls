/var/www/html/moodle:
  file.directory:
    - user: www-data 
    - group: root
    - dir_mode: 755

git config --global --add safe.directory /var/www/html/moodle:
  cmd.run

# Clone moodle repository and change to the latest available stable version branch
clone_moodle_repo:
  git.latest:
    - name: https://github.com/moodle/moodle.git
    - target: /var/www/html/moodle
    - rev: MOODLE_400_STABLE
    - branch: MOODLE_400_STABLE 

chown www-data:www-data /var/www/html/moodle:
  cmd.run

/var/moodledata:
  file.directory:
    - user: www-data
    - group: root
    - dir_mode: 777

cp /var/www/html/moodle/config-dist.php /var/www/html/moodle/config.php:
  cmd.run

# Adjust the moodle config.php file 
dbtype:
  file.replace:
    - name: '/var/www/html/moodle/config.php'
    - pattern: (\$CFG->dbtype\s*=\s*')[^']*(';)
    - repl: '\1pgsql\2'

dbname:
  file.replace:
    - name: '/var/www/html/moodle/config.php'
    - pattern: (\$CFG->dbname\s*=\s*')[^']*(';)
    - repl: '\1moodle\2'

dbuser:
  file.replace:
    - name: '/var/www/html/moodle/config.php'
    - pattern: (\$CFG->dbuser\s*=\s*')[^']*(';)
    - repl: '\1moodleuser\2'

dbpass:
  file.replace:
    - name: '/var/www/html/moodle/config.php'
    - pattern: (\$CFG->dbpass\s*=\s*')[^']*(';)
    - repl: '\1moodlepassword\2'

wwwroot:
  file.replace:
    - name: '/var/www/html/moodle/config.php'
    - pattern: (\$CFG->wwwroot\s*=\s*')[^']*(';)
    - repl: '\1https://thanos.kunde-ssystems.de\2'

dataroot:
  file.replace:
    - name: '/var/www/html/moodle/config.php'
    - pattern: (\$CFG->dataroot\s*=\s*')[^']*(';)
    - repl: '\1/var/moodledata\2'
