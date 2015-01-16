Rails.application.routes.draw do
  resources :words, :path => '' do
    collection do
      get '_autocomplete'
      get '_search'
    end
    member do
      get '/edit'  => 'words#edit'
      get '/versions' => 'versions#index'
      post '/versions/:version_id/revert' => 'versions#revert', :as => 'revert_version'
      get '/:lang' => 'words#translation'
    end
  end
  
end
