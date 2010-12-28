require 'helper'

describe "MMJMenu API client" do

  before do
    @client = Mmjmenu::Client.new('ABC123')
  end

  describe "Menu Items" do 
    it "should return a list of active menu items" do
      stub_get "https://ABC123:x@mmjmenu.com/api/v1/menu_items", "menu_items.json"
      menu_items = @client.menu_items
      menu_items.size.should == 2
      menu_items.first.name.should == 'Kush'
      menu_items.last.name.should == 'Blueberry'
    end
  
    it "should be able to find by a id" do
      stub_get "https://ABC123:x@mmjmenu.com/api/v1/menu_items/10817", "menu_item.json"
      menu_item = @client.menu_item(10817)
      menu_item.success?.should == true
      menu_item.name.should == 'Kush'
    end
  end

end

