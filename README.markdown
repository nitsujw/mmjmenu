## Installation

    sudo gem install mmjmenu
    
## Examples

### List Menu Items
    @client      = Mmjmenu::Client.new('abc123')
    @client.menu_items

### List On-hold Menu Items
    @client      = Mmjmenu::Client.new('abc123')
    @client.menu_items(:status => :on_hold)

### Get a Menu Item
    @client      = Mmjmenu::Client.new('abc123')
    @client.menu_item('12345')

### List Unconfirmed Patients
    @client      = Mmjmenu::Client.new('abc123')
    @client.unconfirmed_patients

