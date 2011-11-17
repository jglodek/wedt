# encoding: utf-8

class Product < ActiveRecord::Base

	belongs_to :bill
	
	#finds similar products, returns product and weight indicating level of similarity 
	def find_similar_products()
		products_all = Product.all
		array = Array.new
		products_all.each do |product|
			ld = Text::Levenshtein.distance(self.name, product.name).to_f # TO FLOAT!
			array.push [product, ( 1/(ld*ld+1) )] #tutaj musi byc wyjatkowo dobra funkcja
		end
		
		array = array.sort {|x,y| y[1] <=> x[1] }
	end
	
	#returns hash with category and weight as index of inclusion's probability
	def product_category
		#find similar products
		similar_products = self.find_similar_products
		# place to store categories with weight as probability of inclusion 
		categories_weight = Hash.new
		#for each of similar products
		similar_products.each do |product_weight|
			#for each category of bills products is on
			product_weight[0].bill.categories.each do |cat|
				#add a weight of this product probability of belonging to this category
				categories_weight[cat] ||= 0
				categories_weight[cat] += product_weight[1]
			end
		end
		categories_weight = categories_weight.sort_by {|cat, weight| -weight}
		#return whole list of probability of inclusion of product in category
		return categories_weight
	end
	
	def self.filltab
		Product.delete_all
		BillCategory.delete_all
		Bill.delete_all
		Category.delete_all
		
		dane_poczatkowe = Array[
												Array["ubrania", Array["czapka","nike","rebook","buty","but. nike","but.reb1","miod","quechua 12 42","quechua 13","spodnie sztruks","jeans 12", "sztruks", "skarpetki"]],
												Array["spozywcze",Array["kefir","krakowska","kielbasa","jogurt naturella","jogurt naturalny","jogurt balkanski","winogr","buł.kajz", "bułka kajzerka", "coca cola","mc zestaw","marchew", "masmix", "masło"]],
												Array["domowe",Array["clin 0.4l","papier toaletowy regina","pasta do zebow","worki na smieci"]]
											]						
		#kategorie
		dane_poczatkowe.each do |element|
			k =  Category.new
			k.name = element[0]
			k.save
		end
		
		#paragony
		for i in 0..30
			b = Bill.new
			b.save
			kat1_id = rand(3)
			kat2_id = rand(3)
			kat1 = Category.all[kat1_id];
			kat2 = Category.all[kat2_id];
			bc = BillCategory.new
			bc.category = kat1;
			bc.bill = b
			bc.save
			if kat1!=kat2
				bc = BillCategory.new
				bc.category = kat2;
				bc.bill = b;
				bc.save
			end
			
			for j in 1..rand(5)
				array = dane_poczatkowe[kat1_id][1]
				p = Product.new
				p.name = array[rand(array.length-1)]
				p.bill = b
				p.save
			end
			for j in 1..rand(5)
				array = dane_poczatkowe[kat2_id][1]
				p = Product.new
				p.name = array[rand(array.length-1)]
				p.bill = b
				p.save
			end
		end
	end
	
	def self.test
		t1 =Array["czapka","nike","rebook","buty","but. nike","but.reb1","miod","quechua 12 42","quechua 13","spodnie sztruks","jeans 12", "sztruks", "skarpetki"]
		t2 =Array["kefir","krakowska","kielbasa","jogurt naturella","jogurt naturalny","jogurt balkanski","winogr","buł.kajz", "bułka kajzerka", "coca cola","mc zestaw","marchew", "masmix", "masło"]
		t3 =Array["clin 0.4l","papier toaletowy regina","pasta do zebow","worki na smieci"]
		puts "UBRANIA"
		t1.each do |e|
			p = Product.new
			p.name = e
			puts "#{e} #{p.product_category[0][0].name}"
		end
		puts "SPOZYWCZE"
		t2.each do |e|
			p = Product.new
			p.name = e
			puts "#{e} #{p.product_category[0][0].name}"
		end
		puts "DOMOWE"
		t3.each do |e|
			p = Product.new
			p.name = e
			puts "#{e} #{p.product_category[0][0].name}"
		end
	end
end
