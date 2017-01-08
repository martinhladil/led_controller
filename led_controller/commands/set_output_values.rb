module LedController
  class SetOutputValues < Command
    def execute(output_values)
      data = []
      data << output_values[:channel_1]
      data << output_values[:channel_2]
      data << output_values[:channel_3]
      data << output_values[:channel_4]
      data << (output_values[:relay_1] ? 1 : 0)
      data << (output_values[:relay_2] ? 1 : 0)
      data << (output_values[:led_usb] ? 1 : 0)
      data << (output_values[:led_external] ? 1 : 0)
      data << (output_values[:led_manual] ? 1 : 0)
      command_frame = build_frame(Protocol::Command::SET_OUTPUT_VALUES, data)
      response_frame = execute_command(command_frame)
      validate_acknowledge_frame(response_frame)
    end
  end
end