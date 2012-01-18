class ProductsController < ApplicationController
	layout nil
	
	def suggest_category
		name = params[:name]
		suggested_category = Category.find_by_id(Product.product_category(name))
		render :json => suggested_category
	end
	
	def create
		params[:product][:category] = Category.find_by_id(params[:product][:category].to_i)
		@product = Product.new params[:product]
		if !@product.valid?
			respond_to do |format|
				format.js {@ok = false}
			end
			return
		end
		
		@product.category_id = Product.product_category(@product.name)
		
		if !@product.save
			respond_to do |format|
				format.js {@ok = false}
			end
			return
		end
		respond_to do |format|
			format.js {@ok = true}
		end
	end
	
	def edit
		@product = Product.find_by_id params[:id]
		render 'form'
	end
	
	def update
		p = Product.find_by_id params[:id]
		p.update_attributes params[:product]
		respond_to do |format|
			format.js
		end
	end
	
	def destroy
		@product = Product.find_by_id params[:id]
		@product.destroy if @product
		render :nothing => true unless @product
	end
end
