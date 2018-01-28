require 'spec_helper'

RSpec.describe 'BitMap' do
  subject { BitMap }

  describe "create" do
    before do
      BitMap.bit_map = []
    end

    it 'creates and stores a bit map of the specified length' do
      BitMap.create(columns_number: 2, rows_number: 3)

      expect(BitMap.bit_map).to eq([['O','O'],['O','O'],['O','O']])
    end

    it 'creates one new each time' do
      BitMap.create(columns_number: 2, rows_number: 3)
      BitMap.create(columns_number: 1, rows_number: 2)

      expect(BitMap.bit_map).to eq([['O'],['O']])
    end
  end
end