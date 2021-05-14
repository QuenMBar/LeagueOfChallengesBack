Rails
    .application
    .routes
    .draw do
        resources :summoners, only: %i[index show]

        # resources :challenges
        resources :created_challenges, only: %i[show create destroy update]
        resources :league_queues, only: %i[show]
        resources :summoner_spells, only: %i[show]
        # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    end
