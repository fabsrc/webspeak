Rails.application.routes.draw do
  resources :words, path: '' do
    collection do
      get '_autocomplete'
      get '_search'
      get '_:lang', to: 'words#index_by_language'
    end
    member do
      get '/edit', to: 'words#edit'
      get '/versions', to: 'versions#index'
      post '/versions/:version_id/revert', to: 'versions#revert',
                                           as: 'revert_version'
      get '/:lang', to: 'words#find_translation', as: 'translation'
    end
  end
end
