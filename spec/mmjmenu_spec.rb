require 'helper'

describe "MMJMenu API client" do

  before do
    @client = Mmjmenu::Client.new('ABC123')
  end

  it "should return a list of active menu items" do
    #stub_get "https://ABC123:x@mmjmenu.com/api/v1/menu_items.json", "menu_items.json"
    stub_get "https://ABC123:x@mmjmenu.com/api/v1/menu_items", "menu_items.json"
    menu_items = @client.list_menu_items
    menu_items.size.should == 2
    menu_items.first.name.should == 'Kush'
    menu_items.last.name.should == 'Blueberry'
  end

end

