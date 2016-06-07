default['certie']['email'] = nil
default['certie']['organization'] = nil

default['certie']['path'] = '/etc/ssl/certs/certie'
default['certie']['certificate_path'] = '/etc/ssl/certs'
default['certie']['domains'] = {}

default['certie']['upgrade_packages'] = true

# for Certbot (letsencrypt)
default['certie']['certbot_webroot'] = '/var/www/certbot'
default['certie']['certbot_path'] = '/etc/letsencrypt'

