Rails.application.routes.draw do
  get 'welcome/index'

  resources :artists do
    resources :songs
  end
end
