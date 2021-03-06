remote_file '/usr/local/bin/certbot' do
  source 'https://dl.eff.org/certbot-auto'
  mode '0755'
  action :create
end

directory node['certie']['certbot_webroot'] do
  recursive true
  action :create
end

directory node['certie']['certbot_path'] do
  action :create
end

node['certie']['domains'].each do |domain, domains|
  execute 'slapadd' do
    command "/usr/local/bin/certbot certonly --config-dir /etc/letsencrypt --work-dir /var/lib/letsencrypt --logs-dir /var/log/letsencrypt --webroot --webroot-path #{node['certie']['certbot_webroot']} --email #{node['certie']['email']} --domains #{domains.join(',')} --expand --agree-tos --non-interactive"
  end

  domains.each do |domain_certificate|
    link "#{domain_certificate} link private key" do
      to "#{node['certie']['certbot_path']}/live/#{domain}/fullchain.pem"
      target_file "#{node['certie']['certificate_path']}/#{domain_certificate}.key"
      not_if { ::File.file?("#{node['certie']['certificate_path']}/#{domain_certificate}.key") }
      action :create
    end

    link "#{domain_certificate} link cert pem" do
      to "#{node['certie']['certbot_path']}/live/#{domain}/privkey.pem"
      target_file "#{node['certie']['certificate_path']}/#{domain_certificate}.pem"
      not_if { ::File.file?("#{node['certie']['certificate_path']}/#{domain_certificate}.pem") }
      action :create
    end
  end
end
