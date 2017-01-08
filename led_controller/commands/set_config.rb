module LedController
  class SetConfig < Command
    def execute(config)
      data = []
      data << config[:model_code]
      CHANNEL_COUNT.times do |index|
        data << CHANNEL_MODES.index(config[:channels][index][:mode])
      end
      RELAY_COUNT.times do |index|
        data << RELAY_MODES.index(config[:relays][index][:mode])
      end
      data << WORKING_MODES.index(config[:working_mode])
      CHANNEL_COUNT.times do |channel_index|
        CHANNEL_POINT_COUNT.times do |point_index|
          data << config[:channels][channel_index][:points][point_index][:hour]
          data << config[:channels][channel_index][:points][point_index][:minute]
        end
      end
      CHANNEL_COUNT.times do |channel_index|
        CHANNEL_POINT_COUNT.times do |point_index|
          data << config[:channels][channel_index][:points][point_index][:value]
        end
      end
      RELAY_COUNT.times do |relay_index|
        RELAY_POINT_COUNT.times do |point_index|
          data << config[:relays][relay_index][:points][point_index][:hour]
          data << config[:relays][relay_index][:points][point_index][:minute]
        end
      end
      RELAY_COUNT.times do |relay_index|
        RELAY_POINT_COUNT.times do |point_index|
          data << config[:relays][relay_index][:points][point_index][:value]
        end
      end
      data << config[:clouds]
      data << config[:storms]
      data << config[:natural_maximum][:hour]
      data << config[:natural_maximum][:minute]
      data << config[:natural_maximum][:value]
      data << config[:latitude].abs
      data << (config[:latitude] < 0 ? COORDINATES_SIGNS.index(:negative) : COORDINATES_SIGNS.index(:positive))
      data << config[:longitude].abs
      data << (config[:longitude] < 0 ? COORDINATES_SIGNS.index(:negative) : COORDINATES_SIGNS.index(:positive))
      data << config[:storms_natural]
      data << config[:moon_day]
      data << config[:moon_selected_day]
      data << config[:moon_selected_month]
      5.times do
        data << 0
      end
      data << (config[:moon] ? 1 : 0)
      data << config[:moon_value]
      data << config[:general_filter]
      data << config[:white_filter]
      data << config[:blue_filter]
      data << config[:depth_filter]
      command_frame = build_frame(Protocol::Command::SET_CONFIG, data)
      response_frame = execute_command(command_frame)
      validate_acknowledge_frame(response_frame)
    end
  end
end
