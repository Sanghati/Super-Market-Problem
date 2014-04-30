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

	def calculate_total_item(chkout_item)
		total_price_of_checkout_item = 0
		number_of_occurrence_of_item = Hash.new(0) 
		chkout_item.each do |item|
			number_of_occurrence_of_item[item] += 1
		end
		@items.each do |item_in_list|
			total_price_of_checkout_item = checkout_rules_of(item_in_list, number_of_occurrence_of_item,total_price_of_checkout_item)
		end
		total_price_of_checkout_item
	end
	
	def checkout_rules_of(item_in_list, number_of_occurrence_of_item,total_price)
	 	number_of_occurrence_of_item.each do |checkout_item, checkout_item_occurence|
			if item_in_list.item_name.chomp == checkout_item
				total_price = pricing_rules(item_in_list,checkout_item_occurence,total_price)	
			end
		end
		total_price
	end

	def pricing_rules(item_in_list, checkout_item_occurence, total_price)
		if item_in_list.offer == true
			if item_in_list.numb_item_offer  == checkout_item_occurence 
				total_price += item_in_list.special_price
			elsif item_in_list.numb_item_offer > checkout_item_occurence 
				total_price = add_price_with_times(checkout_item_occurence, item_in_list.unit_price, total_price)
			elsif item_in_list.numb_item_offer < checkout_item_occurence
				checkout_item_occurence, remaining_checkout_item = offer_within_checkout_item(item_in_list,checkout_item_occurence)
				number_of_special_price_to_add = (checkout_item_occurence / item_in_list.numb_item_offer.to_i)
				total_price = add_price_with_times(number_of_special_price_to_add, item_in_list.special_price, total_price)	
				total_price = add_price_with_times(remaining_checkout_item,item_in_list.unit_price, total_price)		 
			end
		else
			total_price += item_in_list.unit_price
		end
		total_price
	end

	def offer_within_checkout_item(item_in_list,occurrence_of_checkout_item, count = 0)
		until occurrence_of_checkout_item.modulo(item_in_list.numb_item_offer).zero?
		 	occurrence_of_checkout_item -=1
		 	count +=1
		end 
		return [ occurrence_of_checkout_item, count ]
	end

	def add_price_with_times(number_of_times,value,total_price)
		number_of_times.times do
			total_price += value
		end
		total_price
	end
end