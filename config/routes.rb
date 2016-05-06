Rails.application.routes.draw do
  devise_for :users

  get '/*path' => 'application#angular'

  root to: 'application#angular'

  namespace :api, defaults: { format: :json } do
  	namespace :v1 do
  		resources :users, only: [:show] do
  			resources :projects, only: [:index, :show, :create, :update, :destroy] do
  				resources :tasks, only: [:index, :show, :create, :update, :destroy] do
  					resources :subtasks, only: [:index, :show, :create, :update, :destroy]
  				end
  			end
  		end

  		resources :projects, only: [] do
  			resources :tasks, only: [] do
  				resources :subtasks, only: [:index, :show, :create, :update, :destroy]	
  			end
  		end

  		resources :projects, only: [] do
  			resources :tasks, only: [:index, :show, :create, :update, :destroy]
  		end

  		resources :tasks, only: [] do
  			resources :subtasks, only: [:index, :show, :create, :update, :destroy]
  		end


  		resources :groups, only: [:show, :create, :update, :destroy] do
  			resources :projects, only: [:index, :show, :create, :update, :destroy] do
  				resources :tasks, only: [:index, :show, :create, :update, :destroy] do
  					resources :subtasks, only: [:index, :show, :create, :update, :destroy]
  				end
  			end
  		end
  	end
  end
end
