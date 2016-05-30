node['certie']['domains'].each do |domain, domains|
  selfsigned_path = "#{node['certie']['path']}/#{domain}/selfsigned/"

  directory selfsigned_path do
    recursive true
    action :create
    not_if { ::File.directory?(selfsigned_path) }
  end

  template 'openssl-config' do
    source 'openssl.cnf.erb'
    path "#{selfsigned_path}openssl.cnf"
    sensitive true
    variables({
                  :domains => domains,
                  :domain => domain,
                  :organization => node['certie']['organization'],
                  :email => node['certie']['email']
              })
  end

  template 'selfsigned-bash' do
    source 'selfsigned.sh.erb'
    path "/usr/local/bin/generate-selfsign-#{domain}.sh"
    mode '0700'
    variables({
                  :path => selfsigned_path,
                  :domain => domain
              })
  end

  execute "#{domain}-selfsigned-cert" do
    command "generate-selfsign-#{domain}.sh"
    cwd '/usr/local/bin/'
    creates "#{domain}.pem"
    action :run
  end

  link "#{domain} link private key" do
    to "#{selfsigned_path}#{domain}.key"
    target_file "#{node['certie']['certificate_path']}/#{domain}.key"
    not_if { ::File.file?("#{node['certie']['certificate_path']}#{domain}.key") }
    action :create
  end

  link "#{domain} link cert pem" do
    to "#{selfsigned_path}#{domain}.pem"
    target_file "#{node['certie']['certificate_path']}/#{domain}.pem"
    not_if { ::File.file?("#{node['certie']['certificate_path']}#{domain}.pem") }
    action :create
  end
  #
  # //privkey.pem
  # //cert.pem
  # //chain.pem
  # //fullchain.pem

end
