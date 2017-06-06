require 'spec_helper'

RSpec.describe Hitblocks::Error do
  describe 'initialization' do
    it 'should take an error and a status' do
      expect(Hitblocks::Error.new(error: 'Not Found', status: 404)).to be_a Hitblocks::Error
    end
  end
end
