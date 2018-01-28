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

      it 'returns an error if set_pixel fails' do
        line = "L 1 3 A"
        allow(BitMap).to receive(:set_pixel).with({column: 1, row: 3, value: 'A'}).and_return([false, 'Invalid row number'])
        expect(LineProcessor.call(line)).to eq 'Invalid row number'
      end
    end
  end
end