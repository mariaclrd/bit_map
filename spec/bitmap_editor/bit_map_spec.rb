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

  describe "set_vertical" do
    before do
      BitMap.create(columns_number: 5, rows_number: 6)
    end

    it 'sets the vertical' do
      BitMap.set_vertical({column: 2, from_row: 3, to_row: 6, value: 'W'})
      expect(BitMap.bit_map).to eq([
                                       ['O','O','O','O','O'],
                                       ['O','O','O','O','O'],
                                       ['O','W','O','O','O'],
                                       ['O','W','O','O','O'],
                                       ['O','W','O','O','O'],
                                       ['O','W','O','O','O']
                                   ])
    end

    it 'returns an error if row exceeds number of rows' do
      expect(BitMap.set_vertical({column: 2, from_row: 3, to_row: 7, value: 'W'})).to eq([false, 'Invalid row number'])
    end

    it 'returns an error if row is negative' do
      expect(BitMap.set_vertical({column: 2, from_row: -3, to_row: 6, value: 'W'})).to eq([false, 'Invalid row number'])
    end

    it 'returns an error if column exceeds number of rows' do
      expect(BitMap.set_vertical({column: 10, from_row: 3, to_row: 6, value: 'W'})).to eq([false, 'Invalid column number'])
    end

    it 'returns an error if colum is negative' do
      expect(BitMap.set_vertical({column: -2, from_row: 3, to_row: 6, value: 'W'})).to eq([false, 'Invalid column number'])
    end

    it 'returns an error if value is not valid' do
      expect(BitMap.set_vertical({column: 2, from_row: 3, to_row: 6, value: 20})).to eq([false, 'Invalid value'])
    end
  end

  describe "set_horizontal" do
    before do
      BitMap.create(columns_number: 5, rows_number: 6)
    end

    it 'sets an horizontal value' do
      BitMap.set_horizontal({from_column: 3, to_column: 5, row: 2, value: 'Z'})
      expect(BitMap.bit_map).to eq([
                                       ['O','O','O','O','O'],
                                       ['O','O','Z','Z','Z'],
                                       ['O','O','O','O','O'],
                                       ['O','O','O','O','O'],
                                       ['O','O','O','O','O'],
                                       ['O','O','O','O','O']
                                   ])
    end

    it 'returns an error if row exceeds number of rows' do
      expect(BitMap.set_horizontal({from_column: 3, to_column: 5, row: 20, value: 'Z'})).to eq([false, 'Invalid row number'])
    end

    it 'returns an error if row is negative' do
      expect(BitMap.set_horizontal({from_column: 3, to_column: 5, row: -2, value: 'Z'})).to eq([false, 'Invalid row number'])
    end

    it 'returns an error if column exceeds number of rows' do
      expect(BitMap.set_horizontal({from_column: 30, to_column: 5, row: 2, value: 'Z'})).to eq([false, 'Invalid column number'])
    end

    it 'returns an error if colum is negative' do
      expect(BitMap.set_horizontal({from_column: 3, to_column: -5, row: 2, value: 'Z'})).to eq([false, 'Invalid column number'])
    end

    it 'returns an error if value is not valid' do
      expect(BitMap.set_horizontal({from_column: 3, to_column: 5, row: 2, value: 40})).to eq([false, 'Invalid value'])
    end
  end

  describe "reset" do
    before do
      BitMap.create(columns_number: 5, rows_number: 6)
    end

    it 'cleans the bitmap' do
      BitMap.set_horizontal({from_column: 3, to_column: 5, row: 2, value: 'Z'})
      expect(BitMap.bit_map).to eq([
                                       ['O','O','O','O','O'],
                                       ['O','O','Z','Z','Z'],
                                       ['O','O','O','O','O'],
                                       ['O','O','O','O','O'],
                                       ['O','O','O','O','O'],
                                       ['O','O','O','O','O']
                                   ])
      BitMap.reset
      expect(BitMap.bit_map).to eq([
                                       ['O','O','O','O','O'],
                                       ['O','O','O','O','O'],
                                       ['O','O','O','O','O'],
                                       ['O','O','O','O','O'],
                                       ['O','O','O','O','O'],
                                       ['O','O','O','O','O']
                                   ])
    end
  end

  describe 'show' do
    it 'returns the existing bit map' do
      BitMap.create(columns_number: 5, rows_number: 6)
      expect(BitMap.show).to eq([true, ["OOOOO",
                                 "OOOOO",
                                 "OOOOO",
                                 "OOOOO",
                                 "OOOOO",
                                 "OOOOO"
                                ]])
    end

    it 'returns empty array if the is non an exiting map' do
      expect(BitMap.show).to eq [true, []]
    end
  end
end