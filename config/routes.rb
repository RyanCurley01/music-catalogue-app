Rails.application.routes.draw do
  resources :music do
    member do
      get 'same_artist'
      get 'same_genre'
    end
  end

  root to: 'music#index'
end
