require 'spec_helper'

RSpec.describe Hitblocks::Item do
  describe '#initialization' do
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

  describe 'GET .list' do
    before do
      VCR.insert_cassette 'item', record: :new_episodes
      Hitblocks.api_key = "47f2a1acdccbd18e4e8c141934955371"
    end

    after do
      VCR.eject_cassette
    end

    context 'when requested without a hitblock' do
      it 'should return a list' do
        expect(described_class.list).to match Hitblocks::List
      end

      it 'should return a list with all items' do
        expect(described_class.list.data.first).to be_a Hitblocks::Item
      end
    end

    context 'when requested from hitblock' do
      it 'should return all item objects from the hitblock object' do
        expect(Hitblocks::Hitblock.retrieve("1").items).to match [Hitblocks::Item]
      end
    end
  end

  describe 'GET .retrieve' do
  end

  describe 'POST .create' do
  end

  describe 'POST .delete' do
  end

  describe 'POST .post' do
  end
end
