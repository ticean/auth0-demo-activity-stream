Rails.application.routes.draw do
  get 'ping' => 'ping#ping'
  get 'secured/ping' => 'secured_ping#ping'
end
