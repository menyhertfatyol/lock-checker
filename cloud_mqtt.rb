def cloud_mqtt
  uri = URI.parse ENV['CLOUDMQTT_URL']
  {
    remote_host: uri.host,
    remote_port: uri.port,
    username: uri.user,
    password: uri.password,
  }
end
