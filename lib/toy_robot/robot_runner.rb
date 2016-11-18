module ToyRobot
  class RobotRunner
    def initialize(input, output)
      @input  = input  || $stdin
      @output = output || $stdout
      @robot  = ToyRobot::Robot.new

      do_interactive if @input == $stdin
    end

    def run
      @input.each_line do |line|
        args = ToyRobot::CommandParser.call(line)

        if args
          # only `report` returns something
          out = @robot.send(*args)
          @output.print "Output: #{out}\n" if out
        end

        print "<robot> " if @input == $stdin
      end
    end

    def do_interactive
      print "Toy Robot Simulator\n"
      print "-- Ana Djordjevic, 2016\n\n"
      print "Interactive mode - enter commands one line at a time:\n"
      print "Ctrl-D to exit.\n\n"
      print "<robot> "
    end
  end
end
