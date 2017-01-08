module LedController
  class SetTime < Command
    def execute(time)
      data = []
      data << time.year - 2000
      data << time.month
      data << time.day
      data << time.hour
      data << time.min
      data << time.sec
      command_frame = build_frame(Protocol::Command::SET_TIME, data)
      response_frame = execute_command(command_frame)
      validate_acknowledge_frame(response_frame)
    end
  end
end