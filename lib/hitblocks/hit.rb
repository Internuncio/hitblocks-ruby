module Hitblocks

  class HIT

    def initialize(params)
      @url = params["url"],
      @service = params["service"],
      @status = params["status"],
      @created = params["created"],
      @item = params[:item]
    end

  end

end
