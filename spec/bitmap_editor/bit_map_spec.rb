require 'spec_helper'

RSpec.describe 'BitMap' do
  subject { BitMap }

  before do
    BitMap.bit_map = []
  end

  describe "create" do
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

  describe "set_pixel" do
    before do
      BitMap.create(columns_number: 5, rows_number: 6)
    end

    it 'sets the specified pixel' do
      BitMap.set_pixel({column: 1, row: 3, value: 'A'})
      expect(BitMap.bit_map).to eq([
                                       ['O','O','O','O','O'],
                                       ['O','O','O','O','O'],
                                       ['A','O','O','O','O'],
                                       ['O','O','O','O','O'],
                                       ['O','O','O','O','O'],
                                       ['O','O','O','O','O']
                                   ])
    end

    it 'returns an error if row exceeds number of rows' do
      expect(BitMap.set_pixel({column: 1, row: 7, value: 'A'})).to eq([false, 'Invalid row number'])
    end

    it 'returns an error if row is negative' do
      expect(BitMap.set_pixel({column: 1, row: -7, value: 'A'})).to eq([false, 'Invalid row number'])
    end

    it 'returns an error if column exceeds number of rows' do
      expect(BitMap.set_pixel({column: 10, row: 3, value: 'A'})).to eq([false, 'Invalid column number'])
    end

    it 'returns an error if colum is negative' do
      expect(BitMap.set_pixel({column: -1, row: 3, value: 'A'})).to eq([false, 'Invalid column number'])
    end

    it 'returns an error if value is not valid' do
      expect(BitMap.set_pixel({column: 1, row: 3, value: 13})).to eq([false, 'Invalid value'])
    end
  end
end