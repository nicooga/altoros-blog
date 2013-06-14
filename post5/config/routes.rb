Post5::Application.routes.draw do
  root to: 'posts#index'
  resources :posts do
    member { post :vote_up }
  end
end