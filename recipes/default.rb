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
end