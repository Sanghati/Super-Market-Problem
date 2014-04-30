require_relative './list_of_items'

class Option

	def option_add_item(list)
		puts "Enter the Number of items you want to add :"
		numb_item = gets.to_i
		numb_item.times do
			puts "Enter the items name :"
			item_name = gets.to_s
			puts "Enter the Unit price :"
			unit_price = gets.to_i
			puts "Special Offer (Y/N)"
			offer = gets.to_s.chomp
			if offer == "Y"
				offer = true
				puts "For how many items Customer need to buy :"
				numb_offer =gets.to_i
				puts "Special price :"
				special_price = gets.to_i
			else
				offer = false
				numb_offer = 0
				special_price = 0
			end
			list.add_item(Item.new(item_name,unit_price,offer,numb_offer,special_price))
		end
	end

	def option_show_item(list)
		puts "The List of Items are :"
		list.show_all_item
	end

	def checkout_items(list)
		puts "Enter the number of checkout items :"
		numb_chk = gets.to_i
		checkout_item=Array.new(numb_chk)
		puts "Enter the checkout items"
		(0..numb_chk).each {|i| checkout_item[i] = gets.to_s.chomp }
		puts "Total Price :"
		puts  list.calculate_total_item(checkout_item)

	end
end
option = Option.new
list = List.new
while true do
	puts "\nChoose any option below : "
	puts "\n1. Show Items. \n2. Add Item. \n3. Checkout Counter.\n"
	user_option = gets.to_i
	case user_option
		when 1
			option.option_show_item(list)
		when  2
			option.option_add_item(list)	
		when 3
			option.checkout_items(list)
		else
			print "nothing"	
	end
end
