module Hitblocks
  class List
    attr_reader :hitblocks, :items

    def initialize(data)
      @hitblocks = data[:hitblocks]
      @items = data[:items]
    end

  end
end
