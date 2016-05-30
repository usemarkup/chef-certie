=begin
directory node['certbot']['path'] do
  action :create
  not_if { ::File.directory?(node['certbot']['path']) }
end

remote_file '/usr/local/bin/certbot' do
  source 'https://dl.eff.org/certbot-auto'
  mode '0755'
  action :create
end

directory '/etc/letsencrypt' do
  action :create
  not_if { ::File.directory?('/etc/letsencrypt') }
end=end
