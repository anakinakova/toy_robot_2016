module ToyRobot
  class Robot
    
    # each direction points to its left and right directions (like a linked list)
    # x and y are a vector representation of moving 1 unit in that direction
    # value is used when reporting position and direction
    DIRECTIONS = {
      north: {
        x:     0,
        y:     1,
        left:  :west,
        right: :east,
        value: "NORTH",
      },
      east: {
        x:     1,
        y:     0,
        left:  :north,
        right: :south,
        value: "EAST",
      },
      south: {
        x:     0,
        y:     -1,
        left:  :east,
        right: :west,
        value: "SOUTH",
      },
      west: {
        x:     -1,
        y:     0,
        left:  :south,
        right: :north,
        value: "WEST",
      },
    }

    MIN_X = 0
    MIN_Y = 0
    MAX_X = (ENV["GRID_SIZE"] || 5).to_i - 1
    MAX_Y = (ENV["GRID_SIZE"] || 5).to_i - 1

    def initialize(x = nil, y = nil, f = nil)
      set_position(x, y)
      set_direction(f.downcase.to_sym) if f
    end

    # place on the grid at (x, y) in direction f
    def place(x, y, f)
      return unless valid_position?(x, y)
      set_position(x, y)
      set_direction(f.downcase.to_sym)
    end

    # move 1 unit forward in current direction
    def move
      return unless placed?
      # no need to use a loop since the length is only 2
      new_x = @pos_x + @direction[:x]
      new_y = @pos_y + @direction[:y]

      return unless valid_position?(new_x, new_y)
      set_position(new_x, new_y)
    end

    # rotate 90° anti-clockwise
    def left
      return unless placed?
      set_direction(@direction[:left])
    end

    # rotate 90° clockwise
    def right
      return unless placed?
      set_direction(@direction[:right])
    end

    # return position and direction
    def report
      return unless placed?
      [@pos_x, @pos_y, @direction[:value]]
    end

    def position
      return unless placed?
      [@pos_x, @pos_y]
    end

    def direction
      return unless placed?
      @direction[:value]
    end

    private

    def set_position(x, y)
      @pos_x = x
      @pos_y = y
      nil
    end

    def set_direction(key)
      @direction = DIRECTIONS[key]
      nil
    end

    def placed?
      !!@pos_x && !!@pos_y && !!@direction
    end

    def valid_position?(x, y)
      x.between?(MIN_X, MAX_X) && y.between?(MIN_Y, MAX_Y)
    end
  end
end
