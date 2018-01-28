module BitmapEditor
  module LineProcessor
    UNRECOGNISED_COMMAND = 'Unrecognised command'.freeze
    INVALID_COMMAND = 'Invalid use of command'.freeze
    EMPTY_BIT_MAP = 'There is no image'.freeze

    def call(line)
      args = line.split(' ')
      command = args.shift
      case command
      when 'I'
        new_bitmap(args)
      when 'L'
        set_pixel(args)
      when 'V'
        set_vertical(args)
      when 'H'
        set_horizontal(args)
      when 'C'
        reset(args)
      when 'S'
        show(args)
      else
        UNRECOGNISED_COMMAND
      end
    end

    private

    def self.valid_number_of_args?(args, count)
      args.count == count
    end

    def self.new_bitmap(args)
      return INVALID_COMMAND unless valid_number_of_args?(args, 2)
      process_action(BitMap.create(columns_number: args.first.to_i, rows_number: args.last.to_i))
    end

    def self.set_pixel(args)
      return INVALID_COMMAND unless valid_number_of_args?(args, 3)
      process_action(BitMap.set_pixel(column: args.first.to_i, row: args[1].to_i, value: args.last))
    end

    def self.set_vertical(args)
      return INVALID_COMMAND unless valid_number_of_args?(args, 4)
      process_action(BitMap.set_vertical(column: args.first.to_i, from_row: args[1].to_i, to_row: args[2].to_i, value: args.last))
    end

    def self.set_horizontal(args)
      return INVALID_COMMAND unless valid_number_of_args?(args, 4)
      process_action(BitMap.set_horizontal(from_column: args.first.to_i, to_column: args[1].to_i, row: args[2].to_i, value: args.last))
    end

    def self.reset(args)
      return INVALID_COMMAND unless valid_number_of_args?(args, 0)
      process_action(BitMap.reset)
    end

    def self.show(args)
      return INVALID_COMMAND unless valid_number_of_args?(args, 0)
      success, result = BitMap.show
      success ? (result.empty? ? EMPTY_BIT_MAP : result) : result
    end

    def self.process_action(action)
      success, result = action
      success ? nil : result
    end

    module_function :call
  end
end
