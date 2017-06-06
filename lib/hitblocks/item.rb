module Hitblocks

  class Item
    include HTTParty

    attr_accessor :id


    def initialize(params = {})
      self.class.raise_missing_parameters if params.fetch(:id, nil).nil?
      @id = params[:id]
    end

    class << self
      def list
        self.base_uri Hitblocks.api_base
        response = self.get('/items',
                            basic_auth: { username: Hitblocks.api_key }
                           )

        construct_from(response)
      end
    end


    private

    def self.raise_missing_parameters
      raise Hitblocks::MissingParametersError, "Missing ID Parameter"
    end

    def self.construct_from(response)
      parsed_response = response.parsed_response
      self.send("construct_#{parsed_response["object"]}", parsed_response)
    end

    def self.construct_list(parsed_response)
      data = parsed_response["data"]
      list_items = []
      data.each do |object|
        list_items.push(self.send("construct_#{object["object"]}", object))
      end
      Hitblocks::List.new(
        items: list_items
      )
    end

    def self.construct_item(item)
      Hitblocks::Item.new(
        id: item["id"],
        type: item["type"],
        created: item["created"],
        cost: item["cost"],
        currency: item["currency"],
        status: item["status"]
      )
    end


  end

end
