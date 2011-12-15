class ProductController < ApplicationController

	def suggest_category
		name = params[:id]
		suggested_category = Product.product_category(name)
		p = Product.new
		p.name = name
		p.category_id = suggested_category
		render :json => p
	end	

end
