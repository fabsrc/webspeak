Rails.application.routes.draw do
  resources :words, :path => '' do
    collection do
      get 'autocomplete'
      get 'search'
    end
    member do
      get '/edit'  => 'words#edit'
      get '/:lang' => 'words#translation'
    end
  end
end
