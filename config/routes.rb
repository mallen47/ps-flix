Rails.application.routes.draw do    
  
  resources :genres
	root "movies#index"

	resources :movies do 
		resources :reviews
		resources :favorites, only: [:create, :destroy]
	end

	resource :session, only: [:new, :create, :destroy]
	get "signin" => "sessions#new"
	
	resources :users
	get "signup" => "users#new"
	# Todo: create route to users#edit that hides user id

end
