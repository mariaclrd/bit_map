require 'spec_helper'

RSpec.describe 'LineProcessor' do
  subject { LineProcessor }

  describe "call" do

    it 'returns an error when the command passed is not valid' do
      line = "B"
      expect(LineProcessor.call(line)).to eq "Unrecognised command"
    end

    describe "I" do
      it 'returns an error if there are more arguments than expected' do
        line = "I 5 6 7"
        expect(LineProcessor.call(line)).to eq "Invalid use of command"
      end

      it 'sends the number of rows and columns to the bit map class if command is I' do
        line = "I 5 6"
        expect(BitMap).to receive(:create).with({columns_number: 5, rows_number: 6})
        LineProcessor.call(line)
      end
    end

    describe "L" do
      it 'calls the set_pixel method of the BitMap' do
        line = "L 1 3 A"
        expect(BitMap).to receive(:set_pixel).with({column: 1, row: 3, value: 'A'})
        LineProcessor.call(line)
      end

      it 'returns an error if there are more arguments than expected' do
        line = "L 1 3 A B"
        expect(LineProcessor.call(line)).to eq "Invalid use of command"
      end

      it 'returns an error if set_pixel fails' do
        line = "L 1 3 A"
        allow(BitMap).to receive(:set_pixel).with({column: 1, row: 3, value: 'A'}).and_return([false, 'Invalid row number'])
        expect(LineProcessor.call(line)).to eq 'Invalid row number'
      end
    end

    describe "V" do
      it 'calls the set_vertical method of the BitMap' do
        line = "V 2 3 6 W"
        expect(BitMap).to receive(:set_vertical).with({column: 2, from_row: 3, to_row: 6, value: 'W'})
        LineProcessor.call(line)
      end

      it 'returns an error if there are more arguments than expected' do
        line = "V 2 3 6 W Z"
        expect(LineProcessor.call(line)).to eq "Invalid use of command"
      end

      it 'returns an error if set_vertical fails' do
        line = "V 2 3 6 W"
        allow(BitMap).to receive(:set_vertical).with({column: 2, from_row: 3, to_row: 6, value: 'W'}).and_return([false, 'Invalid row number'])
        expect(LineProcessor.call(line)).to eq 'Invalid row number'
      end
    end

    describe "H" do
      it 'calls the set_horizontal method of the BitMap' do
        line = "H 3 5 2 Z"
        expect(BitMap).to receive(:set_horizontal).with({from_column: 3, to_column: 5, row: 2, value: 'Z'})
        LineProcessor.call(line)
      end

      it 'returns an error if there are more arguments than expected' do
        line = "H 3 5 2 Z A"
        expect(LineProcessor.call(line)).to eq "Invalid use of command"
      end

      it 'returns an error if set_vertical fails' do
        line = "H 3 5 2 Z"
        allow(BitMap).to receive(:set_horizontal).with({from_column: 3, to_column: 5, row: 2, value: 'Z'}).and_return([false, 'Invalid row number'])
        expect(LineProcessor.call(line)).to eq 'Invalid row number'
      end
    end
  end
end