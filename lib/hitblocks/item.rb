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

        Hitblocks.construct_from(response)
      end

      def retrieve(id = nil)
        self.raise_missing_parameters unless id
        self.base_uri Hitblocks.api_base
        response = self.get("/items/#{id}",
                            basic_auth: { username: Hitblocks.api_key }
                           )

        Hitblocks.construct_from(response)
      end

      def create(params)
        self.base_uri Hitblocks.api_base
        payload = Hash.new
        payload[:item] = params.reject {|x| x == :hitblock}
        response = self.post("/hitblocks/#{params[:hitblock].id}/items",
                             body: payload.to_json,
                             headers: {
                              'Content-Type' => 'application/json',
                              'Accept' => 'application/json'
                            },
                             basic_auth: { username: Hitblocks.api_key }
                            )

        Hitblocks.construct_from(response)
      end
    end

    def delete
      self.class.base_uri Hitblocks.api_base
      response = self.class.delete("/items/#{self.id}",
                           basic_auth: { username: Hitblocks.api_key }
                          )

      return response
    end

    def post
      self.class.base_uri Hitblocks.api_base
      response = self.class.post("/items/#{self.id}/post",
                                 basic_auth: { username: Hitblocks.api_key }
                                )

      Hitblocks.construct_from(response)
    end

    private

    def self.raise_missing_parameters
      raise Hitblocks::MissingParametersError, "Missing ID Parameter"
    end

  end

end
