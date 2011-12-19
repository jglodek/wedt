class BillsController < ApplicationController
  http_basic_authenticate_with :name => "wedt", :password => "masło"

	def index
		@bills = Bill.all
	end

	def new
		b = Bill.new
		b.save
	  redirect_to bill_path(b)
	end
	
	def show
		@bill = Bill.find_by_id(params[:id])
		@products = @bill.products
		@product = Product.new
		@product.bill = @bill
		redirect_to bills_path if !@bill
	end
	
	def update_bill
	end
	
	def destroy
		b = Bill.find_by_id params[:id]
		b.destroy if b != nil
		redirect_to bills_path()
	end
end
