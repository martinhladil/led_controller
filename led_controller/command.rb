module LedController
  class Command
    include Protocol

    def initialize(options)
      @debug = options[:debug]
      @serial = Serial.new(options[:port], 19200)
    end

    def execute_command(command)
      @serial.write(command)
      debug_frame(command, true)
      sleep(0.05)
      response = @serial.read(512)
      debug_frame(response)
      response
    end

    protected

    def debug_frame(data, write = false)
      output = Paint["#{write ? "W" : "R"}: ", write ? :magenta : :cyan]
      output << Paint[data.unpack("H*").first.upcase.scan(/.{1,2}/).join(" "), :yellow]
      if @debug
        puts(output)
      end
    end
  end
end