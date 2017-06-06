module Hitblocks
  class Hitblock
    include HTTParty

    attr_accessor :id
    attr_reader :items

    class << self
      def retrieve(id = nil)
        self.base_uri Hitblocks.api_base
        raise_missing_parameters if id.nil?
        response = self.get("/hitblocks/#{id}",
                            basic_auth: {
                              username: Hitblocks.api_key, 
                              password: ''
                            })

        construct_from(response)
      end

      def list
        self.base_uri Hitblocks.api_base
        response = self.get("/hitblocks",
                            basic_auth: {
                              username: Hitblocks.api_key,
                              password: ''
                            })
        construct_from(response)
      end
    end

    def initialize(params = {})
      self.class.raise_missing_parameters if params.fetch(:id, nil).nil?
      @id = params[:id]
      @title = params[:title]
      @description = params[:description]
      @type = params[:type]
      @created = params[:created]
      @cost_per_item = params[:cost_per_item]
      @workers_per_item = params[:workers_per_item]
      @currency = params[:currency]
      @items = params[:items]
    end


    private

    def self.raise_missing_parameters
      raise Hitblocks::MissingParametersError, "Missing ID Parameter"
    end

    def self.construct_from(response)
      parsed_response = response.parsed_response
      self.send("construct_#{parsed_response["object"]}", parsed_response)
    end

    def self.construct_hitblock(parsed_response)
      Hitblocks::Hitblock.new(
        id: parsed_response["id"],
        title: parsed_response["title"],
        description: parsed_response["description"],
        type: parsed_response["type"],
        created: parsed_response["created"],
        cost_per_item: parsed_response["cost_per_item"],
        workers_per_item: parsed_response["workers_per_item"],
        currency: parsed_response["currency"],
        items: construct_items(parsed_response["items"])
      )
    end

    def self.construct_list(parsed_response)
      data = parsed_response["data"]
      list_items = []
      data.each do |object|
        list_items.push(self.send("construct_#{object["object"]}", object))
      end
      Hitblocks::List.new(
        hitblocks: list_items
      )
    end

    def self.construct_items(item_list)
      items = []
      item_list.each do |item|
        items.push(Hitblocks::Item.new(
          id: item["id"],
          type: item["type"],
          created: item["created"],
          cost: item["cost"],
          currency: item["currency"],
          status: item["status"]
        ))
      end
      return items
    end
  end
end
