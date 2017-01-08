module LedController
  class SetModeOnline < Command
    def execute
      command_frame = build_frame(Protocol::Command::SET_MODE_ONLINE)
      response_frame = execute_command(command_frame)
      validate_acknowledge_frame(response_frame)
    end
  end
end