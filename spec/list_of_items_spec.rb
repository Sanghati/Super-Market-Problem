require 'spec_helper'

describe List do
    
    before(:all) do
      @list = List.new
      @item_a = Item.new("A",50,true,3,130)
      @item_b = Item.new("B",30,true,2,45)
      @item_c = Item.new("C",20,false,0,0)
      @item_d = Item.new("D",15,false,0,0)
      @list.add_item(@item_a)
      @list.add_item(@item_b)
      @list.add_item(@item_c)
      @list.add_item(@item_d)
      @chkout_item = ["A","A","A","A","A","A","A","A","A","A"]
    end
  
    it 'should add item' do
      expect(@list.items).to match_array([@item_a, @item_b, @item_c, @item_d])
    end

    it 'should calculate total item' do
       @list.calculate_total_item(@chkout_item)
       @list.calculate_total_item(@chkout_item).should eq(440)
    end

    it 'should check the rules of repeated checkout item' do
       @list.checkout_rules_of({'A' => 10},0).should eq(440) 
    end

    it 'should check the pricing rule of item' do
      @list.pricing_rules(@item_a,10,0).should eq(440)
    end

    it 'should return offer and remaining checkout items' do
       @list.offer_within_checkout_item(@item_a,10).should eq([9,1])
    end

    it 'should add price with the required number of times' do
      @list.add_price_with_times(3,130,0).should eq(390)
      @list.add_price_with_times(1,50,390).should eq(440)
    end
end
