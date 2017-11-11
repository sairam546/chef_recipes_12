app = search('aws_opsworks_app').first

git node[:deployer][:app_path] do
  repository app[:app_source][:url]
  revision app[:app_source][:revision]
  user 'deploy'
  group 'deploy'
  action :sync
end