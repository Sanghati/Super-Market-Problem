require_relative './item'
class List
	def initialize()
	  	@items = []
	end

	def add_item(item)
		@items.push(item)
	end

	def show_all_item
		@items.each do |item|
		 	puts item
		end
	end

	def calculate_total_item(checkout_item)
		total_price = 0
		numb_occurrence = Hash.new(0) 
		checkout_item.each do |chk_item|
			numb_occurrence[chk_item] += 1
		end
		@items.each do |item|
			numb_occurrence.each do |chk_item, value|
				if item.item_name.chomp == chk_item
					if item.offer == true
						if item.numb_item_offer  == value
							total_price += item.special_price
						elsif item.numb_item_offer > value ||  item.numb_item_offer < value
							value.times do
								total_price += item.unit_price
							end
						end
					else
						total_price += item.unit_price
					end
				end
			end
		end
		total_price
	end
end
