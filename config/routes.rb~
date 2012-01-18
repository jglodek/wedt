Wedt::Application.routes.draw do
	
	resources :bills
	resources :products
	
	get '/product/suggest_category/:id' => 'products#suggest_category'
	
	root :to => 'bills#index'
end