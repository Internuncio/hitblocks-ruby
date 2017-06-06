require 'spec_helper'

RSpec.describe Hitblocks::Hitblock do
  before do
    VCR.insert_cassette 'hitblock', record: :new_episodes
    Hitblocks.api_key = "47f2a1acdccbd18e4e8c141934955371"
  end

  after do
    VCR.eject_cassette
  end

  describe 'initialization' do
    it 'must include HTTParty' do
      expect(described_class.ancestors).to include(HTTParty)
    end

    it 'will raise an error without an ID parameter' do
      expect{described_class.new}.to raise_error(Hitblocks::MissingParametersError)
    end

    it 'will accept an ID parameter' do
      expect(described_class.new(id: "45").id).to eq ("45")
    end
  end


  describe 'GET .retrieve' do
    it 'will raise an error without an ID parameter', vcr: true do
      expect{described_class.retrieve}.to raise_error(Hitblocks::MissingParametersError)
    end

    it 'will return a hitblock object with a proper id' do
      expect(described_class.retrieve("1")).to be_a Hitblocks::Hitblock
    end
  end

  describe 'GET .list' do
    it 'will return a list object' do
      expect(described_class.list).to be_a Hitblocks::List
    end

    it 'will return a list object with hitblocks' do
      expect(described_class.list.data).to match [Hitblocks::Hitblock]
    end
  end

end
