#! /usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "toy_robot"
require "optparse"

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

ToyRobot::RobotRunner.new(options[:input], options[:output]).run
