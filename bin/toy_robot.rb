#! /usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "toy_robot"
require "optparse"

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

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: toy_robot.rb [-i|--input-file input -o|--output-file output]"

  opts.on("-o", "--output-file FILE", "Use specified output file") do |file|
    begin
      options[:output] = File.open(file, "w")
    rescue
      $stderr.puts "ERROR: Unable to open file #{file} for writing."
      $stderr.puts "Writing output to standard output."
    end
  end

  opts.on("-i", "--input-file FILE", "Use specified input file") do |file|
    begin
      options[:input] = File.open(file, "r")
    rescue Errno::ENOENT
      $stderr.puts "ERROR: Unable to open file #{file} for reading."
      $stderr.puts "Falling back to interactive mode."
    end
  end
end.parse!

RobotRunner.new(options[:input], options[:output]).run
