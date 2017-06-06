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
    end


    private

    def self.raise_missing_parameters
      raise Hitblocks::MissingParametersError, "Missing ID Parameter"
    end

  end

end
