Rails.application.routes.draw do

  root 'item#index'
	get '/items' => 'items#index' , as: :items
  get '/items/new' => 'item#new'
 	get 'items' => 'items#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
