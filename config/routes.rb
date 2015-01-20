Rails.application.routes.draw do

  get 'signup'      => 'users#new'
  get 'login'       => 'sessions#new'
  post 'login'      => 'sessions#create'
  delete 'logout'   => 'sessions#destroy'

  resources :users

  resources :words, :path => '' do
    collection do
      get 'autocomplete'
      get 'search'
    end
  end

  root to: 'words#index'

end
