module Hitblocks
  class List
    attr_reader :data

    def initialize(data)
      @data = data[:data]
    end

  end
end
