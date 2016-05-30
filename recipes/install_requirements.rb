case node['platform_family']
  when 'rhel'
    include_recipe 'yum-epel::default'

    # Taken from https://github.com/certbot/certbot/blob/master/letsencrypt-auto#L260
    packages = %w(
      gcc
      dialog
      augeas-libs
      openssl
      openssl-devel
      libffi-devel
      redhat-rpm-config
      ca-certificates
      python
      python-devel
      python-virtualenv
      python-tools
      python-pip
    )
  else
    raise 'We currently do not support installing the third party requirements '
end

if node['certie']['upgrade_packages']
  package_action = 'upgrade'
else
  package_action = 'install'
end

package packages do
  action package_action
end