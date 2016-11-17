module ToyRobot
  class Robot
    
    # each direction points to its left and right directions (like a linked list)
    # move is a vector representation of moving 1 unit in that direction
    # value is used when reporting position and direction
    DIRECTIONS = {
      north: {
        move:  [0, 1],
        left:  DIRECTIONS[:west],
        right: DIRECTIONS[:east],
        value: 'NORTH',
      },
      east: {
        move:  [1, 0],
        left:  DIRECTIONS[:north],
        right: DIRECTIONS[:south],
        value: 'EAST',
      },
      south: {
        move:  [0, -1],
        left:  DIRECTIONS[:east],
        right: DIRECTIONS[:west],
        value: 'SOUTH',
      },
      west: {
        move:  [-1, 0],
        left:  DIRECTIONS[:south],
        right: DIRECTIONS[:north],
        value: 'WEST',
      },
    }

    MIN_X = 0
    MIN_Y = 0
    MAX_X = ENV['GRID_SIZE'] - 1
    MAX_Y = ENV['GRID_SIZE'] - 1

    def initialize
      @position  = nil
      @direction = nil
    end

    # place on the grid at (x, y) in direction f
    def place(x, y, f)
      new_position = [x, y]
      return unless valid_position?(new_position)
      @position   = new_position
      @direction  = DIRECTIONS[f.downcase.to_sym]
    end

    # move 1 unit forward in current direction
    def move
      # no need to use a loop since the length is only 2
      new_position = [
        @position[0] + @direction[:move][0],
        @position[1] + @direction[:move][1] ]

      return unless valid_position?(new_position)
      @position = new_position
    end

    # rotate 90° anti-clockwise
    def left
      @direction = @direction[:left]
    end

    # rotate 90° clockwise
    def right
      @direction = @direction[:right]
    end

    # return position and direction
    def report
      @position + @direction[:value]
    end

    def position
      @position
    end

    def direction
      @direction[:value]
    end

    private

    def valid_position?([x, y])
      x.between?(MIN_X, MAX_X) && y.between?(MIN_Y, MAX_Y)
    end
  end
end
