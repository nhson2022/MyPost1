Rails.application.routes.draw do
  
  root "pages#home"
  devise_for :users
  resources :posts
  # get 'profiles/show'
  # get 'profiles/my'
  resources :profiles, only: %[show] do
    post "/follow/:user_id" => "profiles#follow", on: :collection, as: :follow
    collection do
      get :my
    end
  end
end
