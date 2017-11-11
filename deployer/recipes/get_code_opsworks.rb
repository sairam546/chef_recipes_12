app = search('aws_opsworks_app').first

git app_root do
  repository app[:app_source][:url]
  revision app[:app_source][:revision]
  user 'deploy'
  group 'deploy'
  action :sync
end