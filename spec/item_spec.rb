require 'spec_helper'

RSpec.describe Hitblocks::Item do
  before do
    VCR.insert_cassette 'item', record: :new_episodes
    Hitblocks.api_key = "47f2a1acdccbd18e4e8c141934955371"
  end

  after do
    VCR.eject_cassette
  end

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
    it 'should return an item' do
      expect(described_class.retrieve("1")).to be_a Hitblocks::Item
    end

    it 'should raise an error without an ID parameter', vcr: true do
      expect{described_class.retrieve}.to raise_error(Hitblocks::MissingParametersError)
    end
  end

  describe 'POST .create' do
    it 'should return a new item' do
      hitblock = Hitblocks::Hitblock.retrieve("1")
      item = described_class.create(
          type: "image",
          hitblock: hitblock,
          image_url: 'http://www.images.com/my-image.jpg',
          description: "My image from a personal website")
      expect(item).to be_a Hitblocks::Item
    end
  end

  describe 'POST .delete' do
    context 'when the deletion is successful' do
      it 'should return the deleted hash' do
        item = Hitblocks::Item.new(id: 2)
        response = item.delete

        expect(response["deleted"]).to eq true
      end
    end

    context 'when the deletion is unsuccessful' do
      it 'should return the deleted hash' do
        item = Hitblocks::Item.new(id: 3)
        response = item.delete

        expect(response["deleted"]).to eq false
      end
    end
  end

  describe 'POST .post' do
  end
end
