nginx:
  pkg.installed

nginx Service:
  service.running:
    - name: nginx
    - enable: true

ufw allow 'Nginx Full':
  cmd.run:
    - unless: "ufw status verbose | grep 'Nginx Full'"
