module Mmjmenu
  class UnexpectedResponseError < RuntimeError
  end
  
  class Parser < HTTParty::Parser
    def parse
      begin
        Crack::JSON.parse(body)
      rescue => e
        raise UnexpectedResponseError, "Crack could not parse JSON. It said: #{e.message}. Mmjmenu's raw response: #{body}"
      end
    end
  end
  
  class Client
    include HTTParty
    
    parser Mmjmenu::Parser
    headers 'Content-Type' => 'application/json' 
    
    attr_reader :api_key
    
    # Your API key can be generated on the settings screen.
    def initialize(api_key)
      @api_key = api_key
      
      self.class.base_uri "https://mmjmenu.com/api/v1"
      self.class.basic_auth @api_key, 'x'
      
    end
    
    def menu_items(options={})
      options[:status] ||= 'active'
      if options[:status].to_s.downcase == 'on_hold'
        request = get("/menu_items/on_hold", :query => options)
      else
        request = get("/menu_items", :query => options)
      end
      request['menu_items'].map{|c| Hashie::Mash.new(c)}
    end
    
    def menu_item(menu_item_id, options={})
      request = get("/menu_items/#{menu_item_id}")
      success = request.code == 200
      response = Hashie::Mash.new(request) if success
      Hashie::Mash.new(response['menu_item'] || {}).update(:success? => success)
    end
    
    private
    
    def post(path, options={})
      jsonify_body!(options)
      self.class.post(path, options)
    end
  
    def put(path, options={})
      jsonify_body!(options)
      self.class.put(path, options)
    end
    
    def delete(path, options={})
      jsonify_body!(options)
      self.class.delete(path, options)
    end
    
    def get(path, options={})
      jsonify_body!(options)
      self.class.get(path, options)
    end
    
    def jsonify_body!(options)
      options[:body] = options[:body].to_json if options[:body]
    end
  end
end
