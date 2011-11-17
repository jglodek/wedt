class Bill < ActiveRecord::Base

	has_many :products
	has_many :categories, :through => :bill_categories
	has_many :bill_categories
	
end
