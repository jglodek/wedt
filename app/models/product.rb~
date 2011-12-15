class Product < ActiveRecord::Base
	belongs_to :bill
	belongs_to :category
	
	validates_presence_of :bill, :category
	
	#pseudo fuzzy
	def self.product_category (name)
		#get all products -- maybe not all? LIKE "<first letter>%"
		products = Product.all
		
		#Associate weight of name similarity with product categorie, Fuzzyfication
		weights = products.collect do |prod|
			#should use levenshtein without transpositions and substitutions!
			ld = Text::Levenshtein.distance(name, prod.name).to_f #to float!!! 
			weight = 1/(ld*ld+1) #heuristic
			Array[ prod.category_id, weight ]
		end

		#create hash for weight sum 
		categories = Hash.new

		#sum weight
		weights.each do |weight|
			categories[weight[0]] ||= 0
			categories[weight[0]] += weight[1]
		end
		
		#sort categories by weights
		categories.sort {|x,y| y[1] <=> x[1]}.first[0]
	end
	
end
