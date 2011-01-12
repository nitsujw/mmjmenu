require 'helper'

describe "MMJMenu API client" do

  before do
    @client = Mmjmenu::Client.new('ABC123')
  end

  describe "Menu Items" do 
    it "should return a list of active menu items" do
      stub_get "https://ABC123:x@mmjmenu.com/api/v1/menu_items?status=active", "menu_items.json"
      menu_items = @client.menu_items
      menu_items.size.should == 2
      menu_items.first.name.should == 'Kush'
      menu_items.first.on_hold.should == false
      menu_items.last.name.should == 'Blueberry'
    end
    
    it "should return a list of on hold menu items" do
      stub_get "https://ABC123:x@mmjmenu.com/api/v1/menu_items/on_hold?status=on_hold", "menu_items_on_hold.json"
      menu_items = @client.menu_items(:status => 'on_hold')
      menu_items.size.should == 2
      menu_items.first.name.should == 'Kush Hold'
      menu_items.first.on_hold.should == true
      menu_items.last.name.should == 'Blueberry Hold'
    end
  
    it "should be able to find by a id" do
      stub_get "https://ABC123:x@mmjmenu.com/api/v1/menu_items/10817", "menu_item.json"
      menu_item = @client.menu_item(10817)
      menu_item.success?.should == true
      menu_item.name.should == 'Kush'
    end
  end
  
  describe "Patients" do 
    it "should return a list of unconfirmed patients" do
      stub_get "https://ABC123:x@mmjmenu.com/api/v1/patients/unconfirmed", "unconfirmed_patients.json"
      patients = @client.unconfirmed_patients
      patients.size.should == 2
      patients.first.name.should == 'Jane Doe'
      patients.first.confirmed.should == false
      patients.last.name.should == 'John Doe'
    end
  end

end

