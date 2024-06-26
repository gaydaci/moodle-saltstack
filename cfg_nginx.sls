# Moodle configuration file for nginx
/etc/nginx/conf.d/moodle.conf:
  file.managed:
    - source: salt://nginx/moodle.conf
    - user: www-data
    - group: www-data
    - mode: 644

rm -rf /var/moodledata/cache/*:
  cmd.run

rm -rf /var/moodledata/localcache/*:
  cmd.run
  
nginx -t:
  cmd.run

restart_nginx_service:
  # Force service.running to always restart the service.
  test.succeed_with_changes:
    - watch_in:
      - service: restart_nginx_service
  service.running:
    - name: nginx
    - enable: True
