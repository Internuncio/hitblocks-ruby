require 'spec_helper'

RSpec.describe 'Authorization' do
  describe 'accessing a resource' do
    context 'when an API key is not set' do
      before do
        VCR.insert_cassette 'authorization', record: :new_episodes
        Hitblocks.api_key = nil
      end

      after do
        VCR.eject_cassette
      end

      it 'returns an error' do
        expect{Hitblocks::Hitblock.retrieve("1")}.to raise_error(Hitblocks::APIKeyNotSet)
      end
    end

    context 'when an API key is incorrect' do
      before do
        VCR.insert_cassette 'authorization', record: :new_episodes
        Hitblocks.api_key = 'xxx'
      end

      after do
        VCR.eject_cassette
      end

      it 'returns an error' do
        expect{Hitblocks::Item.retrieve("1")}.to raise_error(Hitblocks::APIKeyIncorrect)
      end

    end
  end
end
