module BitmapEditor
  class BitMap
    class << self
      attr_writer :bit_map

      WHITE_BIT = 'O'.freeze
      NUMBER_OF_ROWS_EXCEEDED = 'Invalid row number'.freeze
      NUMBER_OF_COLUMNS_EXCEEDED = 'Invalid column number'.freeze
      INVALID_VALUE = 'Invalid value'.freeze

      def bit_map
        @bit_map ||= []
      end

      def create(rows_number:, columns_number:)
        self.bit_map = Array.new(rows_number).map { |_row| Array.new(columns_number).map { WHITE_BIT } }
      end

      def set_pixel(row:, column:, value:)
        return error(NUMBER_OF_ROWS_EXCEEDED) unless valid_row?(row)
        return error(NUMBER_OF_COLUMNS_EXCEEDED) unless valid_column?(column)
        return error(INVALID_VALUE) unless valid_value?(value)
        bit_map[row - 1][column - 1] = value
        success_response
      end

      def set_vertical(column:, from_row:, to_row:, value:)
        return error(NUMBER_OF_ROWS_EXCEEDED) unless valid_row?(from_row) && valid_row?(to_row)
        return error(NUMBER_OF_COLUMNS_EXCEEDED) unless valid_column?(column)
        return error(INVALID_VALUE) unless valid_value?(value)
        bit_map[(from_row - 1)..(to_row - 1)].each do |row|
          row[(column - 1)] = value
        end
        success_response
      end

      def set_horizontal(from_column:, to_column:, row:, value:)
        return error(NUMBER_OF_ROWS_EXCEEDED) unless valid_row?(row)
        return error(NUMBER_OF_COLUMNS_EXCEEDED) unless valid_column?(from_column) && valid_column?(to_column)
        return error(INVALID_VALUE) unless valid_value?(value)
        new_row = bit_map[(row - 1)].map.with_index { |element, index| index.between?((from_column - 1), (to_column - 1)) ? value : element }
        bit_map[row - 1] = new_row
        success_response
      end

      def reset
        rows_number = bit_map.size
        columns_number = bit_map.first.size
        create(rows_number: rows_number, columns_number: columns_number)
        success_response
      end

      def show
        current_bitmap = bit_map.map(&:join)
        success_response(current_bitmap)
      end

      private

      def success_response(result = nil)
        [true, result]
      end

      def error(message)
        [false, message]
      end

      def valid_row?(row)
        row > 0 && row <= bit_map.size
      end

      def valid_column?(column)
        column > 0 && column <= bit_map.first.size
      end

      def valid_value?(value)
        valid_values = (10...36).map { |i| i.to_s(36).upcase }
        valid_values.include?(value)
      end
    end
  end
end
