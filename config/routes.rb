Rails.application.routes.draw do
  get '/beers', to: "beers#get_beers"
  get '/beers/:id', to: "beers#get_beer" 
  resources :beers
end
