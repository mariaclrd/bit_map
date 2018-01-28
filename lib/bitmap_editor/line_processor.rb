module BitmapEditor
  module LineProcessor

    UNRECOGNISED_COMMAND = 'Unrecognised command'.freeze
    INVALID_COMMAND = 'Invalid use of command'.freeze

    def call(line)
      args = line.split(' ')
      command = args.shift
      case command
        when 'I'
          new_bitmap(args)
        when 'L'
          set_pixel(args)
        when 'S'
          puts "There is no image"
        else
          UNRECOGNISED_COMMAND
      end
    end

    private

    def self.valid_create_args?(args)
      args.count == 2
    end

    def self.valid_set_pixel_args?(args)
      args.count == 3
    end

    def self.new_bitmap(args)
      return INVALID_COMMAND unless valid_create_args?(args)
      BitMap.create(columns_number: args.first.to_i, rows_number: args.last.to_i)
      nil
    end

    def self.set_pixel(args)
      return INVALID_COMMAND unless valid_set_pixel_args?(args)
      success, result = BitMap.set_pixel(column: args.first.to_i, row: args[1].to_i, value: args.last)
      success ? nil : result
    end

    module_function :call
  end
end