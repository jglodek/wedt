class Product < ActiveRecord::Base
	belongs_to :bill
	belongs_to :category
	
	validates_presence_of :bill, :name
	validates :name, :length => {:minimum => 2}
	#pseudo fuzzy
	def self.product_category (name)
		#get all products -- maybe not all? LIKE "<first letter>%"
		products = Product.where("category_id is not null")
		name = name.downcase
		#Associate weight of name similarity with product categorie, Fuzzyfication
		weights = products.collect do |prod|
			#should use levenshtein without transpositions and substitutions!
			ld = Text::Levenshtein::distance(name, prod.name.downcase).to_f #to float!!! 
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
	
	private
	#customized levenshtein distance
	#voids substitution
	def self.levenshtein_distance(str1,str2)
		matrix = Hash.new
		
		s1a = str1.split(//)
		s2a = str2.split(//)
		
		s1l = str1.length-1
		s2l = str2.length-1
		
		for i in 0..s1l
			matrix[[i,0]] = i
		end
		for i in 0..s2l
			matrix[[0,i]] = i
		end
		
		for i in 1..s1l
			for j in 1..s2l
				if s1a[i] = s2a[j]
					matrix[[i,j]]= matrix[[i-1,j-1]]
				else
					matrix[[i,j]] = 
							[
								matrix[[i-1,j]]+1, #deletion
								matrix[[i,j-1]]+1,#insertion
# 								matrix[[i-1,j-1]]+1 #substitution
							]
				end
				
			end
		end
		return matrix[[s1l,s2l]]
	end
	
end
