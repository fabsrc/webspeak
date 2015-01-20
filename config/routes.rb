Rails.application.routes.draw do

  get 'signup'      => 'users#new'
  get 'login'       => 'sessions#new'
  post 'login'      => 'sessions#create'
  delete 'logout'   => 'sessions#destroy'

  resources :users

  resources :words, :path => '' do
    collection do
      get '_autocomplete'
      get '_search'
    end
    member do
      get '/edit'  => 'words#edit'
      get '/:lang' => 'words#translation'
    end
  end

  root to: 'words#index'

end
