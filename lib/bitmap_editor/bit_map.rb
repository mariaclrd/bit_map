module BitmapEditor
  class BitMap
    class << self
      attr_writer :bit_map

      WHITE_BIT = 'O'.freeze

      def bit_map
        @bit_map ||= []
      end

      def create(rows_number:, columns_number: )
        self.bit_map = Array.new(rows_number).map{|row| Array.new(columns_number).map{|element| WHITE_BIT} }
      end
    end
  end
end