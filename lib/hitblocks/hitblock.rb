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
                            })

        Hitblocks.construct_from(response)
      end

      def list
        self.base_uri Hitblocks.api_base
        response = self.get("/hitblocks",
                            basic_auth: {
                              username: Hitblocks.api_key,
                            })

        Hitblocks.construct_from(response)
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

  end
end
