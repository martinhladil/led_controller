module LedController
  class GetConfig < Command
    def execute
      command_frame = build_frame(Protocol::Command::GET_CONFIG)
      response_frame = execute_command(command_frame)
      data = validate_frame_and_extract_data(response_frame, Protocol::Command::GET_CONFIG, 212)
      index = 0
      config = {}
      config[:model_code] = data[index]
      config[:channels] = []
      CHANNEL_COUNT.times do
        config[:channels] << { mode: CHANNEL_MODES[data[index += 1]], points: [] }
      end
      config[:relays] = []
      RELAY_COUNT.times do
        config[:relays] << { mode: RELAY_MODES[data[index += 1]], points: [] }
      end
      config[:working_mode] = WORKING_MODES[data[index += 1]]
      CHANNEL_COUNT.times do |channel_index|
        CHANNEL_POINT_COUNT.times do |point_index|
          point = {}
          point[:hour] = data[index += 1]
          point[:minute] = data[index += 1]
          config[:channels][channel_index][:points][point_index] = point
        end
      end
      CHANNEL_COUNT.times do |channel_index|
        CHANNEL_POINT_COUNT.times do |point_index|
          config[:channels][channel_index][:points][point_index][:value] = data[index += 1]
        end
      end
      RELAY_COUNT.times do |relay_index|
        RELAY_POINT_COUNT.times do |point_index|
          point = {}
          point[:hour] = data[index += 1]
          point[:minute] = data[index += 1]
          config[:relays][relay_index][:points][point_index] = point
        end
      end
      RELAY_COUNT.times do |relay_index|
        RELAY_POINT_COUNT.times do |point_index|
          config[:relays][relay_index][:points][point_index][:value] = data[index += 1]
        end
      end
      config[:clouds] = data[index += 1]
      config[:storms] = data[index += 1]
      config[:natural_maximum] = {}
      config[:natural_maximum][:hour] = data[index += 1]
      config[:natural_maximum][:minute] = data[index += 1]
      config[:natural_maximum][:value] = data[index += 1]
      config[:latitude] = data[index += 1]
      config[:latitude] *= -1 if COORDINATES_SIGNS[data[index += 1]] == :negative
      config[:longitude] = data[index += 1]
      config[:longitude] *= -1 if COORDINATES_SIGNS[data[index += 1]] == :negative
      config[:storms_natural] = data[index += 1]
      config[:moon_day] = data[index += 1]
      config[:moon_selected_day] = data[index += 1]
      config[:moon_selected_month] = data[index += 1]
      index += 5
      config[:moon] = data[index += 1] == 1
      config[:moon_value] = data[index += 1]
      config[:general_filter] = data[index += 1]
      config[:white_filter] = data[index += 1]
      config[:blue_filter] = data[index += 1]
      config[:depth_filter] = data[index += 1]
      config
    end
  end
end