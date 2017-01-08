module LedController
  class GetInputValues < Command
    def execute
      command_frame = build_frame(Protocol::Command::GET_INPUT_VALUES)
      response_frame = execute_command(command_frame)
      data = validate_frame_and_extract_data(response_frame, Protocol::Command::GET_INPUT_VALUES, 7)
      input_values = {}
      input_values[:manual_1] = data[0]
      input_values[:manual_2] = data[1]
      input_values[:external_1] = data[2]
      input_values[:external_2] = data[3]
      input_values[:button] = data[4] != 0
      input_values[:external] = data[5] != 0
      input_values[:usb] = data[6] != 0
      input_values
    end
  end
end