Rails.application.routes.draw do
  resources :music do
    member do
      get 'same_artist'
    end
  end

  root to: 'music#index'
end
