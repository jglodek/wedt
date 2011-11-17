class Category < ActiveRecord::Base
	has_many :bills, :through => :bill_categories
	has_many :bill_categories
end
