module Hitblocks

  class Error

    attr_reader :error, :status

    def initialize(params)
      @error = params[:error]
      @status = params[:status]
    end

  end
end
