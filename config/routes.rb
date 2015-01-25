Rails.application.routes.draw do
  resources :words, path: '' do
    collection do
      get '_autocomplete', to: 'search#autocomplete'
      get '_search', to: 'search#search', as: 'search'
      get '_:lang', to: 'words#index_by_language'
    end
    member do
      get '/versions', to: 'versions#index'
      post '/versions/:version_id/revert', to: 'versions#revert',
                                           as: 'revert_version'
      get '/_:lang', to: 'words#find_translation', as: 'translation'
    end
  end
end
