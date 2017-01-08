module LedController
  class GetVersion < Command
    def execute
      command_frame = build_frame(Protocol::Command::GET_VERSION)
      response_frame = execute_command(command_frame)
      data = validate_frame_and_extract_data(response_frame, Protocol::Command::GET_VERSION, 4)
      version = {}
      version["hardware"] = data[0..1].join(".")
      version["firmware"] = data[2..3].join(".")
      version
    end
  end
end