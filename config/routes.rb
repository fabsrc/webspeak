Rails.application.routes.draw do
  get '_signup', to: 'users#new', as: 'signup'
  get '_login', to: 'sessions#new', as: 'login'
  post '_login', to: 'sessions#create'
  delete '_logout', to: 'sessions#destroy', as: 'logout'

  get '_autocomplete',  to: 'search#autocomplete'
  get '_search',        to: 'search#search', as: 'search'

  resources :users
  resources :words, path: '' do
    collection do
      get '_:lang', to: 'words#index_by_language', as: 'language'
    end
    member do
      scope :versions do
        get '/', to: 'versions#index', as: 'versions'
        post '/:version_id/revert', to: 'versions#revert',
                                    as: 'revert_version'
      end
      get '/_:lang', to: 'words#find_translation', as: 'translation'
    end
  end
  root to: 'words#index'
end
