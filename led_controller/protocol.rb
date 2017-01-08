module LedController
  module Protocol
    module Command
      SET_TIME = 0x01
      GET_INPUT_VALUES = 0x02
      SET_OUTPUT_VALUES = 0x03
      SET_CONFIG = 0x04
      GET_CONFIG = 0x05
      GET_VERSION = 0x06
      GET_INFO = 0x07
      SET_MODE_ARTIFICIAL = 0x08
      SET_MODE_NATURAL = 0x09
      SET_MODE_ONLINE = 0x0A
      RUN_QUICK_MODE = 0x0B
      ENTER_BOOTLOADER = 0x0C
      GET_STATUS = 0x0D
      ACKNOWLEDGE = 0x88
      ERROR = 0x66
    end

    START_OF_FRAME = 0xAA
    END_OF_FRAME = 0x33

    CHANNEL_COUNT = 4
    RELAY_COUNT = 2
    CHANNEL_POINT_COUNT = 12
    RELAY_POINT_COUNT = 6

    CHANNEL_MODES = [:not_used, :white, :blue, :red, :yellow].freeze
    RELAY_MODES = [:not_used, :used].freeze
    WORKING_MODES = [nil, nil, nil, :artificial, :natural].freeze

    CLIMATES = [nil, :sunny, :cloudy, :stormy].freeze
    MOON_STATUSES = [nil, :last_quarter, :first_quarter, :new_moon, :full_moon].freeze

    COORDINATES_SIGNS = [:nil, :positive, :negative]

    def build_frame(command, data = [])
      frame = []
      frame << START_OF_FRAME
      frame << command
      frame << data.size
      frame += data
      frame << END_OF_FRAME
      frame.pack("C*")
    end

    def validate_frame_and_extract_data(frame, command, size)
      frame = frame.unpack("C*")
      if frame[0] != START_OF_FRAME || frame[1] != command || frame[2] != size || frame[-1] != END_OF_FRAME || frame.size != size + 4
        raise InvalidFrame
      else
        frame[3..-2]
      end
    end

    def validate_acknowledge_frame(frame)
      begin
        validate_frame_and_extract_data(frame, Command::ACKNOWLEDGE, 0)
        true
      rescue InvalidFrame
        validate_frame_and_extract_data(frame, Command::ERROR, 0)
        false
      end
    end
  end
end
