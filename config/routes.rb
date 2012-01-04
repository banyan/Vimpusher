Vimpusher::Application.routes.draw do
  resources :users
  resources :plugins, except: %w(new create destroy)

  match 'settings' => 'users#edit',   :via => 'get', :as => :settings
  match 'settings' => 'users#update', :via => 'put'

  match '/auth/failure'                 => 'sessions#failure'
  match '/auth/:provider/callback', :to => 'sessions#callback'
  match '/signup'                       => 'users#new',        :as => :signup
  match '/login'                        => 'sessions#new',     :as => :login
  match '/logout'                       => 'sessions#destroy', :as => :logout

  mount Resque::Server, :at => "/resque"

  match ':username' => 'users#show'
  root :to => 'home#index'
end
