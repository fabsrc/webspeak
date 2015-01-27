Rails.application.routes.draw do
  get 'signup',    to: 'users#new'
  get 'login',     to: 'sessions#new'
  post 'login',    to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users
  resources :words, path: '' do
    collection do
      get '_autocomplete',  to: 'search#autocomplete'
      get '_search',        to: 'search#search', as: 'search'
      get '_:lang',         to: 'words#index_by_language'
    end
    member do
      get '/versions', to: 'versions#index'
      post '/versions/:version_id/revert', to: 'versions#revert',
                                           as: 'revert_version'
      get '/_:lang', to: 'words#find_translation', as: 'translation'
    end
  end

  root to: 'words#index'
end
