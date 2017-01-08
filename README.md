# LED Controller
Command line tool for [Blau Aquaristic Lumina LED](http://www.blau-aquaristic.com/led-lumina.html)

WARNING: This tool is experimental. You may brick your LED controller.

```
Commands:
  led_controller.rb get_config              # Load config from LED controller
  led_controller.rb get_input_values        # Display LED controller input values
  led_controller.rb get_status              # Display LED controller status
  led_controller.rb get_version             # Display hardware and firmware version
  led_controller.rb help [COMMAND]          # Describe available commands or one specific command
  led_controller.rb run_quick_mode MINUTES  # Simulate 24-hour period in specified number of minutes
  led_controller.rb set_config FILE         # Save config to LED controller
  led_controller.rb set_mode_artificial     # Put LED controller to artificial mode
  led_controller.rb set_mode_natural        # Put LED controller to natural mode
  led_controller.rb set_mode_online         # Put LED controller to online mode
  led_controller.rb set_output_values FILE  # Set LED controller output values
  led_controller.rb set_time                # Set LED controller time to system time

Options:
  -p, --port=PORT
      [--debug], [--no-debug]
```