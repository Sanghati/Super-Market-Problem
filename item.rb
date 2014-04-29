
class Item
	
	attr_accessor :item_name , :unit_price, :offer, :numb_item_offer, :special_price
	
	def  initialize(item_name, unit_price, offer, numb_item_offer, special_price)
		@item_name = item_name
		@unit_price = unit_price
		@offer = offer
		@numb_item_offer = numb_item_offer
		@special_price = special_price
	end

	def to_s 
		"Item Name : #{@item_name}\n
    	 	 Unit Price : #{@unit_price}\n
    	  	 Special Price :\n
    	  	 #{@numb_item_offer} for #{@special_price}\n"
	end
end
