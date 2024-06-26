certbot:
  pkg.removed

snap install core && snap refresh core:
  cmd.run

snap install --classic certbot:
  cmd.run

# create symlink, so certbot can run
link-certbot:
  file.symlink:
    - name: /usr/bin/certbot
    - target: /snap/bin/certbot

# Get certificate from certbot and automatically add it to the nginx configuration
# --test-cert for staging environment
certbot --nginx --test-cert --agree-tos --no-eff-email -d thanos.kunde-ssystems.de -m thanos.gkaidatzis@gmail.com:
  cmd.run

# Test automatic renewal for certificates
certbot renew --dry-run:
  cmd.run



