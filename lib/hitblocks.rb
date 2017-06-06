#Hitblocks Ruby bindings
# API spec at https://docs.hitblocks.ai

require "httparty"
require "json"

require "hitblocks/version"
require "hitblocks/errors"
require "hitblocks/hitblock"
require "hitblocks/list"

module Hitblocks

  @api_base = 'http://internuncio-prototype-staging.herokuapp.com/api/'

  class << self
    attr_accessor :api_base, :api_key
  end
end
