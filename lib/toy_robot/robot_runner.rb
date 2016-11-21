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
        if @input == $stdin
          case line.strip
          when "?", "help"
            print_help
            next
          when "exit"
            break
          end
        end

        args = ToyRobot::CommandParser.call(line)

        if args
          # only `report` returns something
          out = @robot.send(*args)
          @output.print "Output: #{out.join(", ")}\n" if out
        end

        print "<robot> " if @input == $stdin
      end
    end

    def do_interactive
      puts <<~WELCOME
        Toy Robot Simulator -- Ana Djordjevic, 2016

        Interactive mode - enter commands one line at a time.
        `?` for help, or `exit` to exit.

      WELCOME

      print "<robot> "
    end

    def print_help
      puts <<~HELP

        ? | help -- this help

        exit
          Exit the simulator.

        PLACE X,Y,DIRECTION
          Place the robot at (X, Y) facing DIRECTION.
          DIRECTION can be NORTH, EAST, SOUTH, or WEST.

        MOVE
          Move the robot one unit in the direction it is facing.

        LEFT
          Turn the robot 90° anti-clockwise.

        RIGHT
          Turn the robot 90° clockwise.

        REPORT
          Report the position and direction of the robot.

      HELP

      print "<robot> "
    end
  end
end
