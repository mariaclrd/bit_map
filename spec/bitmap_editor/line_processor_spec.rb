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
  end
end