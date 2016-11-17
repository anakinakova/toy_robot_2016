module ToyRobot
  class CommandParser

    # must have a space after PLACE
    # allow extra whitespace between args
    COMMANDS = [
      /\s*(MOVE)\s*/,
      /\s*(LEFT)\s*/,
      /\s*(RIGHT)\s*/,
      /\s*(REPORT)\s*/,
      /\s*(PLACE)\s+\s*([0-9])\s*,\s*([0-9])\s*,\s*(NORTH|SOUTH|EAST|WEST)/,
    ]

    def self.call(command_string)
      COMMANDS.each do |command|
        match = command_string.match(command)
        if match
          args = match.captures
          args[0] = args[0].downcase
          args
          break
        end
      end
    end
  end
end
