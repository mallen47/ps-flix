Rails.application.routes.draw do    
    
	root "movies#index"

	resources :genres

	resources :movies do 
		resources :reviews
		resources :favorites, only: [:create, :destroy]
	end

	get "movies/filter/:filter" => "movies#index", as: :filtered_movies

	resource :session, only: [:new, :create, :destroy]
	get "signin" => "sessions#new"
	
	resources :users
	get "signup" => "users#new"
	# Todo: create route to users#edit that hides user id

end
