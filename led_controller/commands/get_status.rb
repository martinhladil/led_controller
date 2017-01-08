module LedController
  class GetStatus < Command
    def execute
      command_frame = build_frame(Protocol::Command::GET_STATUS)
      response_frame = execute_command(command_frame)
      data = validate_frame_and_extract_data(response_frame, Protocol::Command::GET_STATUS, 20)
      status = {}
      status[:time] = Time.new(2000 + data[0], data[1], data[2], data[3], data[4], data[5])
      status[:latitude] = COORDINATES_SIGNS[data[7]] == :negative ? -data[6] : data[6]
      status[:longitude] = COORDINATES_SIGNS[data[9]] == :negative ? -data[8] : data[8]
      status[:water_depth] = data[10]
      status[:working_mode] = WORKING_MODES[data[11]]
      status[:sunrise_time] = Time.new(2000, 1, 1, data[12], data[13])
      status[:sunset_time] = Time.new(2000, 1, 1, data[14], data[15])
      status[:clouds] = data[16]
      status[:storms] = data[17]
      status[:climate] = CLIMATES[data[18]]
      status[:moon_status] = MOON_STATUSES[data[19]]
      status
    end
  end
end