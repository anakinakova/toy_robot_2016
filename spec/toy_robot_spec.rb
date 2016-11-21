require "spec_helper"

describe ToyRobot do
  let(:welcome_msg) { "Toy Robot Simulator -- Ana Djordjevic, 2016\n\nInteractive mode - enter commands one line at a time.\n`?` for help, or `exit` to exit.\n\n<robot> " }
  let(:executable) { "bin/toy_robot.rb" }

  it "has a version number" do
    expect(ToyRobot::VERSION).not_to be nil
  end

  # invalid commands
  # invalid moves
  # valid commands before first PLACE
  # multiple PLACE commands
  it "extended test" do
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

    output = `./bin/toy_robot.rb -i ./spec/fixtures/test_input.txt`
    expect(output).to eq(expected)
  end

  context "when input file can't be opened for reading" do
    let(:cmd) { 'echo "exit" | ./bin/toy_robot.rb -i asdfsadfasdf' }
    let(:read_error) { "ERROR: Unable to open file asdfsadfasdf for reading.\nFalling back to interactive mode.\n" }

    it "falls back to stdin" do
      expect {
        system(cmd)
      }.to output.to_stdout_from_any_process
    end

    it "prints error message" do
      expect {
        system(cmd)
      }.to output(
        read_error
      ).to_stderr_from_any_process
    end
  end

  context "when output file can't be opened for writing" do
    let(:cmd) { "./bin/toy_robot.rb -i ./spec/fixtures/test_input.txt -o ./spec/fixtures/unwritable.txt" }
    let(:write_error) { "ERROR: Unable to open file ./spec/fixtures/unwritable.txt for writing.\nWriting output to standard output.\n" }

    before { `chmod 444 ./spec/fixtures/unwritable.txt` }

    it "falls back to stdout" do
      expect {
        system(*cmd)
      }.to output.to_stdout_from_any_process
    end

    it "prints error message" do
      expect {
        system(*cmd)
      }.to output(
        write_error
      ).to_stderr_from_any_process
    end
  end
end
