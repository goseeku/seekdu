Rails.application.routes.draw do
  devise_for :users

  get '/*path' => 'application#angular'

  root to: 'application#angular'
end
