require "spec_helper"

RSpec.describe Hitblocks do
  it "has a version number" do
    expect(Hitblocks::VERSION).not_to be nil
  end

  it "has a base api path" do
    expect(Hitblocks.api_base).not_to be nil
  end

  it "can set an api key" do
    Hitblocks.api_key = "xxx-xxx-xxx"
    expect(Hitblocks.api_key).to eq "xxx-xxx-xxx"
  end
end
