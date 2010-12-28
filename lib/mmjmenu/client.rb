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
    
    def list_menu_items(options={})
      menu_items = get("/menu_items", :query => options)
      menu_items.map{|c| Hashie::Mash.new(c)}
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
