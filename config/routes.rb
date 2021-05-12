Rails
    .application
    .routes
    .draw do
        resources :summoners do
            get 'new_challenges', :show
            get 'all_challenges', :show
        end

        # resources :challenges
        resources :created_challenges
        # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    end
