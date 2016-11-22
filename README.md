# Toy Robot Simulator

## Description

A simulation of a toy robot moving on a square tabletop of dimensions 5 units x 5 units.

* There are no obstructions on the table surface.
* The robot is free to roam around the surface of the table.
* The robot is prevented from falling to destruction. _(Any movement that would result in the robot falling from the table is prevented, however further valid movement commands are still allowed.)_
* The first command the robot will respond to is a valid PLACE command.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'toy_robot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install toy_robot

## Usage
The simulator can read from STDIN or a given file, and output to STDOUT or a given file.

    $ toy_robot.rb [-i input_file] [-o output_file]

Commands are of the following form:

```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```


### Example Input and Output:
```
PLACE 0,0,NORTH
MOVE
REPORT
Output: 0,1,NORTH
```

```
PLACE 0,0,NORTH
LEFT
REPORT
Output: 0,0,WEST
```

```
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
Output: 3,3,NORTH
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

