module BitmapEditor
  module LineProcessor

    UNRECOGNISED_COMMAND = 'Unrecognised command'.freeze
    INVALID_COMMAND = 'Invalid use of command'.freeze

    def call(line)
      args = line.split(" ")
      command = args.shift
      case command
        when "I"
          return INVALID_COMMAND unless valid_create_args?(args)
          BitMap.create(columns_number: args.first.to_i, rows_number: args.last.to_i)
          nil
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

    module_function :call
  end
end