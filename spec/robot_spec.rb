require "spec_helper"

describe ToyRobot::Robot do
  let(:robot) { ToyRobot::Robot.new }

  context "when not on the board" do
    it "commands other than report produce no output" do
      expect(robot.place(1, 2, "EAST")).to be_nil
      expect(robot.place(1, -2, "EAST")).to be_nil
      expect(robot.left).to be_nil
      expect(robot.right).to be_nil
      expect(robot.move).to be_nil
    end
  end

  context "when on the board" do
    let(:robot) { ToyRobot::Robot.new(1, 1, "NORTH") }

    it "commands other than report produce no output" do
      expect(robot.place(1, 2, "EAST")).to be_nil
      expect(robot.place(1, -2, "EAST")).to be_nil
      expect(robot.left).to be_nil
      expect(robot.right).to be_nil
      expect(robot.move).to be_nil
    end

    context "invalid move" do
      let(:robot) { ToyRobot::Robot.new(1, 4, "NORTH") }

      it "produces no output" do
        expect(robot.move).to be_nil
      end
    end
  end

  subject { robot }

  describe "#place" do
    context "when the robot is not already on the board" do
      context "when coordinates are invalid" do
        before { robot.place(-2, 3, "SOUTH") }

        its(:position) { is_expected.to be_nil }
        its(:direction) { is_expected.to be_nil }
      end

      context "when the coordinates are valid" do
        before { robot.place(2, 3, "SOUTH") }

        its(:position) { is_expected.to eq [2, 3] }
        its(:direction) { is_expected.to eq "SOUTH" }
      end
    end

    context "when the robot is already on the board" do
      let(:robot) { ToyRobot::Robot.new(1, 2, "WEST") }

      context "when coordinates are invalid" do
        before { robot.place(-2, 3, "SOUTH") }

        its(:position) { is_expected.to eq [1, 2] }
        its(:direction) { is_expected.to eq "WEST" }
      end

      context "when the coordinates are valid" do
        before { robot.place(4, 1, "NORTH") }

        its(:position) { is_expected.to eq [4, 1] }
        its(:direction) { is_expected.to eq "NORTH" }
      end
    end
  end

  describe "#move" do
    before { robot.move }

    context "when the robot is not on the board" do
      its(:position) { is_expected.to be_nil }
      its(:direction) { is_expected.to be_nil }
    end

    context "when the robot is on the board" do
      context "when a move is invalid" do
        let(:robot) { ToyRobot::Robot.new(4, 1, "EAST") }

        its(:position) { is_expected.to eq [4, 1] }
        its(:direction) { is_expected.to eq "EAST" }
      end

      context "when a move is valid" do
        let(:robot) { ToyRobot::Robot.new(4, 1, "WEST") }

        its(:position) { is_expected.to eq [3, 1] }
        its(:direction) { is_expected.to eq "WEST" }
      end
    end
  end

  describe "#left" do
    before { robot.left }

    context "when the robot is not on the board" do
      its(:position) { is_expected.to be_nil }
      its(:direction) { is_expected.to be_nil }
    end

    context "when facing NORTH" do
      let(:robot) { ToyRobot::Robot.new(1, 2, "NORTH") }

      its(:position) { is_expected.to eq [1, 2] }
      its(:direction) { is_expected.to eq "WEST" }
    end

    context "when facing EAST" do
      let(:robot) { ToyRobot::Robot.new(1, 4, "EAST") }

      its(:position) { is_expected.to eq [1, 4] }
      its(:direction) { is_expected.to eq "NORTH" }
    end

    context "when facing SOUTH" do
      let(:robot) { ToyRobot::Robot.new(3, 2, "SOUTH") }

      its(:position) { is_expected.to eq [3, 2] }
      its(:direction) { is_expected.to eq "EAST" }
    end

    context "when facing WEST" do
      let(:robot) { ToyRobot::Robot.new(4, 0, "WEST") }

      its(:position) { is_expected.to eq [4, 0] }
      its(:direction) { is_expected.to eq "SOUTH" }
    end
  end

  describe "#right" do
    before { robot.right }

    context "when the robot is not on the board" do
      its(:position) { is_expected.to be_nil }
      its(:direction) { is_expected.to be_nil }
    end

    context "when facing NORTH" do
      let(:robot) { ToyRobot::Robot.new(1, 2, "NORTH") }

      its(:position) { is_expected.to eq [1, 2] }
      its(:direction) { is_expected.to eq "EAST" }
    end

    context "when facing EAST" do
      let(:robot) { ToyRobot::Robot.new(1, 4, "EAST") }

      its(:position) { is_expected.to eq [1, 4] }
      its(:direction) { is_expected.to eq "SOUTH" }
    end

    context "when facing SOUTH" do
      let(:robot) { ToyRobot::Robot.new(3, 2, "SOUTH") }

      its(:position) { is_expected.to eq [3, 2] }
      its(:direction) { is_expected.to eq "WEST" }
    end

    context "when facing WEST" do
      let(:robot) { ToyRobot::Robot.new(4, 0, "WEST") }

      its(:position) { is_expected.to eq [4, 0] }
      its(:direction) { is_expected.to eq "NORTH" }
    end
  end

  describe "#report" do
    context "when the robot is not on the board" do
      its(:position) { is_expected.to be_nil }
      its(:direction) { is_expected.to be_nil }
    end

    context "when the robot is on the board" do
      let(:robot) { ToyRobot::Robot.new(1, 2, "WEST") }

      it "gives the position and direction as an array" do
        expect(robot.report).to eq [1, 2, "WEST"]
      end
    end
  end
end
