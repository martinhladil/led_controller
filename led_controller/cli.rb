require "yaml"
require_relative "exceptions"
require_relative "protocol"
require_relative "command"
require_relative "commands/get_config"
require_relative "commands/get_input_values"
require_relative "commands/get_status"
require_relative "commands/get_version"
require_relative "commands/run_quick_mode"
require_relative "commands/set_config"
require_relative "commands/set_mode_artificial"
require_relative "commands/set_mode_natural"
require_relative "commands/set_mode_online"
require_relative "commands/set_output_values"
require_relative "commands/set_time"

module LedController
  class CLI < Thor
    class_option :port, required: true, aliases: "-p"
    class_option :debug, type: :boolean

    option :file, aliases: "-f"
    desc "get_config", "Load config from LED controller"
    def get_config
      config = GetConfig.new(options).execute
      yaml = config.to_yaml
      if options[:file]
        File.open(options[:file], "w") do |file|
          file.write(yaml)
        end
      else
        puts yaml
      end
    end

    desc "get_input_values", "Display LED controller input values"
    def get_input_values
      input_values = GetInputValues.new(options).execute
      puts input_values.to_yaml
    end

    desc "get_status", "Display LED controller status"
    def get_status
      status = GetStatus.new(options).execute
      puts status.to_yaml
    end

    desc "get_version", "Display hardware and firmware version"
    def get_version
      version = GetVersion.new(options).execute
      puts version.to_yaml
    end

    desc "run_quick_mode MINUTES", "Simulate 24-hour period in specified number of minutes"
    def run_quick_mode(minutes)
      acknowledge(RunQuickMode.new(options).execute(minutes.to_i))
    end

    desc "set_config FILE", "Save config to LED controller"
    def set_config(file)
      config = YAML.load_file(file)
      acknowledge(SetConfig.new(options).execute(config))
    end

    desc "set_mode_artificial", "Put LED controller to artificial mode"
    def set_mode_artificial
      acknowledge(SetModeArtificial.new(options).execute)
    end

    desc "set_mode_natural", "Put LED controller to natural mode"
    def set_mode_natural
      acknowledge(SetModeNatural.new(options).execute)
    end

    desc "set_mode_online", "Put LED controller to online mode"
    def set_mode_online
      acknowledge(SetModeOnline.new(options).execute)
    end

    desc "set_output_values FILE", "Set LED controller output values"
    def set_output_values(file)
      output_values = YAML.load_file(file)
      acknowledge(SetOutputValues.new(options).execute(output_values))
    end

    desc "set_time", "Set LED controller time to system time"
    def set_time
      acknowledge(SetTime.new(options).execute(Time.now))
    end

    protected

    def acknowledge(response)
      if response
        puts Paint["OK", :green]
      else
        puts Paint["ERROR", :red]
      end
    end
  end
end