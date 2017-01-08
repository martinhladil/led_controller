module LedController
  class RunQuickMode < Command
    def execute(minutes)
      command_frame = build_frame(Protocol::Command::RUN_QUICK_MODE, [minutes])
      response_frame = execute_command(command_frame)
      validate_acknowledge_frame(response_frame)
    end
  end
end