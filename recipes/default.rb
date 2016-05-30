include_recipe '::install_requirements'

if node['certie']['email'].nil?
  raise 'Email attribute can not be nil'
end

if node['certie']['organization'].nil?
  raise 'Organization attribute can not be nil'
end

if node['certie']['domains'].empty?
  raise 'Domain names are not configured'
end

directory node['certie']['path'] do
  action :create
  not_if { ::File.directory?(node['certie']['path']) }
end


# template '/etc/letsencrypt/cli.ini' do
#   source 'config.ini.erb'
#   variables({
#                 :params => {
#                     :email => node['certbot']['email'],
#                     :domains => node['certbot']['domains'].join(',')
#                 }
#             })
# end
#
# directory '/etc/ssl/certs/certbot/' do
#   action :create
#   not_if { ::File.directory?('/etc/ssl/certs/certbot/') }
# end
#
# include_recipe '::selfsigned'
#
# if node['certbot']['dryrun']
#   include_recipe '::certbot_dryrun'
# end
#
# if node['certbot']['live']
#   include_recipe '::certbot'
# end