require "spec_helper"

describe ToyRobot::RobotRunner do
  let(:runner) { ToyRobot::RobotRunner.new(input_stream, output_stream) }
  let(:input_stream) { StringIO.new("PLACE 1, 2, NORTH\nREPORT\nexit") }
  let(:output_stream) { $stdout }

  context "when input is stdin" do
    it "reads from stdin" do
      expect{ runner.run }.to output("Output: 1, 2, NORTH\n").to_stdout
    end
  end

  context "when input is a file" do
    let(:input_stream) { File.open("./spec/fixtures/test_input.txt") }

    it "reads input from file" do
      expected = <<~EXPECTED
        Output: 1, 4, NORTH
        Output: 1, 4, WEST
        Output: 0, 4, WEST
        Output: 4, 3, SOUTH
        Output: 4, 2, SOUTH
        Output: 4, 1, SOUTH
        Output: 4, 0, WEST
        Output: 2, 0, WEST
        Output: 2, 1, NORTH
      EXPECTED

      expect { runner.run }.to output(expected).to_stdout
    end
  end

  context "when output is stdout" do
    it "can output to stdout" do
      expect{ runner.run }.to output("Output: 1, 2, NORTH\n").to_stdout
    end
  end

  context "when output is a file" do
    let(:output_stream) { File.open("test_output.txt", "w") }

    before do
      runner.run
      output_stream.close
    end

    after { `rm test_output.txt` }

    it "writes to the file specified" do
      written = File.read("test_output.txt")
      expect(written).to eq("Output: 1, 2, NORTH\n")
    end
  end
end
