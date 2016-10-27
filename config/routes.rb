Rails.application.routes.draw do

  root 'item#index'
	get '/item' => 'item#index' , as: :items
  get '/item/new' => 'item#new', as: :new_item
  get  '/item/:id' => 'item#show', as: :item

  post '/item' => 'item#create' #, as: :item
  get  '/item/:id/edit' => 'item#edit', as: :edit_item
  patch '/item/:id' => 'item#update'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
