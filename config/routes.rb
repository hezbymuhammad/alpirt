Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      resources :users, only: [ :index ] do
        resources :circles, only: [ :index ] do
          collection do
            post :follow
            delete :unfollow
          end
        end

        resources :sleep_histories, only: [ :index ] do
          collection do
            post :sleep
            post :wake_up
            get :following
          end
        end
      end
    end
  end
end
