#Hitblocks Ruby bindings
# API spec at https://docs.hitblocks.ai

require "faraday"
require "json"

require "hitblocks/version"

module Hitblocks

  @api_base = 'https://www.hitblocks.ai/api/v1'

  class << self
    attr_accessor :api_base, :api_key
  end
end
