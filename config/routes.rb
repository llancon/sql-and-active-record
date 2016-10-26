Rails.application.routes.draw do

  root 'item#index'
	get '/items' => 'items#index' , as: :items

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
