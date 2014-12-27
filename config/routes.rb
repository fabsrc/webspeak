Rails.application.routes.draw do
  resources :words, :path => '' do
    collection do
      get 'autocomplete'
      get 'search'
    end
  end
end
