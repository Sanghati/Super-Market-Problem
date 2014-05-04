require_relative './item'
class List
	attr_reader :items

	def initialize()
	  	@items = []
	end

	def add_item(item)
		@items.push(item)
	end

	def show_all_item
		@items.each {|item| puts item}
	end

	def calculate_total_item(chkout_item)
		total_price = 0
		count_repeated_checkout_item = Hash.new(0) 
		chkout_item.each { |item| count_repeated_checkout_item[item] += 1}
		checkout_rules_of(count_repeated_checkout_item,total_price)
	end
	
	def checkout_rules_of(count_repeated_checkout_item,total_price)
	 	@items.each do |item_in_list|
		 	count_repeated_checkout_item.each { |key, value| 
			total_price = pricing_rules(item_in_list, value, total_price) if item_in_list.item_name.chomp == key }
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
				offer_checkout_item, remaining_checkout_item = offer_within_checkout_item(item_in_list,checkout_item_occurence)
				count_special_price_item = (offer_checkout_item / item_in_list.numb_item_offer.to_i)
				total_price = add_price_with_times(count_special_price_item, item_in_list.special_price, total_price)	
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
		number_of_times.times { total_price += value }
		total_price
	end

end
