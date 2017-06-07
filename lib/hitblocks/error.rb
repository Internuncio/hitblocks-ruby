module Hitblocks

  class Error

    attr_reader :error, :status

    def initialize(params)
      @error = params[:error]
      @status = params[:status]

      if @error.match /Invalid Token/
        raise Hitblocks::APIKeyIncorrect, "Your API key is incorrect. Please double check and set the value with Hitblocks.api_key = 'YOUR-API-KEY-HERE'"
      end
    end

  end
end
