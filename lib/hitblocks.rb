#Hitblocks Ruby bindings
# API spec at https://docs.hitblocks.ai

require "httparty"
require "json"

require "hitblocks/version"
require "hitblocks/errors"
require "hitblocks/hitblock"
require "hitblocks/list"
require "hitblocks/item"
require "hitblocks/error"
require "hitblocks/hit"

module Hitblocks

  @api_base = 'http://internuncio-prototype-staging.herokuapp.com/api/'

  class << self
    attr_accessor :api_base, :api_key
  end

  def self.construct_HIT(parsed_response)
    Hitblocks::HIT.new(
      url: parsed_response["url"],
      service: parsed_response["service"],
      status: parsed_response["status"],
      created: parsed_response["created"],
      item: construct_item(parsed_response["item"])
    )
  end


  def self.construct_from(response)
    parsed_response = response.parsed_response
    if parsed_response["object"]
      self.send("construct_#{parsed_response["object"]}", parsed_response)
    else
      construct_error(parsed_response)
    end
  end

  def self.construct_error(parsed_response)
    Hitblocks::Error.new(
      error: parsed_response["error"],
      status: parsed_response["status"]
    )
  end

  def self.construct_list(parsed_response)
    data = parsed_response["data"]
    list_items = []
    data.each do |object|
      list_items.push(self.send("construct_#{object["object"]}", object))
    end
    Hitblocks::List.new(
      data: list_items
    )
  end

  def self.construct_item(item)
    Hitblocks::Item.new(
      id: item["id"],
      type: item["type"],
      created: item["created"],
      cost: item["cost"],
      currency: item["currency"],
      status: item["status"]
    )
  end

  def self.construct_hitblock(parsed_response)
    Hitblocks::Hitblock.new(
      id: parsed_response["id"],
      title: parsed_response["title"],
      description: parsed_response["description"],
      type: parsed_response["type"],
      created: parsed_response["created"],
      cost_per_item: parsed_response["cost_per_item"],
      workers_per_item: parsed_response["workers_per_item"],
      currency: parsed_response["currency"],
      items: construct_items(parsed_response["items"])
    )
  end

  def self.construct_items(item_list)
    items = []

    item_list.each do |item|
      items.push(Hitblocks::Item.new(
        id: item["id"],
        type: item["type"],
        created: item["created"],
        cost: item["cost"],
        currency: item["currency"],
        status: item["status"]
      ))
    end

    return items
  end
end
