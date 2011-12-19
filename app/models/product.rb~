class Product < ActiveRecord::Base
	belongs_to :bill
	belongs_to :category
	
	validates_presence_of :bill, :name
	validates :name, :length => {:minimum => 2}
	#pseudo fuzzy
	def self.product_category (name)
		
		#get all products -- maybe change that
		products = Product.where("category_id is not null")
		
		name = name.downcase
		#Associate weight of name similarity with product categorie, Fuzzyfication
		weights = products.collect do |prod|
			#should use levenshtein without transpositions and substitutions!
			ld = levenshtein_distance(name, prod.name.downcase).to_f #to float!!! 
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
		categories.sort {|x,y| y[1] <=> x[1]}.first[0] if categories.size>0
	end
	
	private
	#customized levenshtein distance
	#voids substitution
	def self.levenshtein_distance(s1,s2)
		s1l = s1.length
		s2l = s2.length
		s1a = s1.split(//)
		s2a = s2.split(//)
		d = Hash.new
		
		for i in 0..s1l
			d[[i,0]]=i
		end
		for j in 0..s2l
			d[[0,j]]=j
		end
		
		for x in 1..s1l
			for y in 1..s2l
				if s1a[x-1]==s2a[y-1]
					d[[x,y]]= d[[x-1,y-1]]
				else
					d[[x,y]]=
						[
							d[[x-1,y]]+1,
							d[[x,y-1]]+1,
							#d[[x-1,y-1]]+1
						].min
				end
			end
		end
		return d[[s1l,s2l]]
	end

end
