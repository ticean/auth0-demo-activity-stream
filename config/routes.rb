Rails.application.routes.draw do
  get 'ping' => 'ping#ping'
  get 'secured/ping' => 'secured_ping#ping'
  get 'streams/:app_id(/:stream_id)' => 'streams#show'
end
