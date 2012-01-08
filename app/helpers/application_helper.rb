module ApplicationHelper
	
	def category_name(category)
		if(category and category.category)
			"#{category_name(category.category)} : #{category.name}"
		else
			"#{category.name}" if category
		end
	end
end
