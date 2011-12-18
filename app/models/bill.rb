class Bill < ActiveRecord::Base
	has_many :products
	has_many :categories, through: :products
end
