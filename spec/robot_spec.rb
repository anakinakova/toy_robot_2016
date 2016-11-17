require "spec_helper"

describe ToyRobot::Robot do
  let(:toy_robot) { ToyRobot::Robot.new }

  describe "#place" do
    subject { toy_robot.place(*args) }

    context "when the robot is not already on the board" do
      context "when coordinates are invalid" do
        let(:args) { [-2, 3, "SOUTH"] }

        its(:position) { is_expected.to be_nil }
        its(:direction) { is_expected.to be_nil }
      end

      context "when the coordinates are valid" do
        let(:args) { [2, 3, "SOUTH"] }

        its(:position) { is_expected.to eq [2, 3] }
        its(:direction) { is_expected.to eq "SOUTH" }
      end
    end

    context "when the robot is already on the board" do
      before { toy_robot.place(1, 2, "WEST") }
    
      context "when coordinates are invalid" do
        let(:args) { [-2, 3, "SOUTH"] }

        its(:position) { is_expected.to eq [1, 2] }
        its(:direction) { is_expected.to eq "WEST" }
      end

      context "when the coordinates are valid" do
        let(:args) { [4, 1, "NORTH"] }

        its(:position) { is_expected.to eq [4, 1] }
        its(:direction) { is_expected.to eq "NORTH" }
      end
    end
  end

  describe "#move" do
    subject { toy_robot.move }

    context "when a move is invalid" do
      before { toy_robot.place(4, 1, "EAST") }

      its(:position) { is_expected.to eq [4, 1] }
      its(:direction) { is_expected.to eq "EAST" }
    end

    context "when a move is valid" do
      before { toy_robot.place(4, 1, "WEST") }

      its(:position) { is_expected.to eq [3, 1] }
      its(:direction) { is_expected.to eq "WEST" }
    end
  end

  describe "#left" do
    subject { toy_robot.left }

    context "when facing NORTH" do
      before { toy_robot.place(1, 2, "NORTH") }

      context "does not change position" do
        its(:position) { is_expected.to eq [1, 2] }
      end

      its(:direction) { is_expected.to eq "WEST" }
    end

    context "when facing EAST" do
      before { toy_robot.place(1, 4, "EAST") }

      context "does not change position" do
        its(:position) { is_expected.to eq [1, 4] }
      end

      its(:direction) { is_expected.to eq "NORTH" }
    end

    context "when facing SOUTH" do
      before { toy_robot.place(3, 2, "SOUTH") }

      context "does not change position" do
        its(:position) { is_expected.to eq [3, 2] }
      end

      its(:direction) { is_expected.to eq "EAST" }
    end

    context "when facing WEST" do
      before { toy_robot.place(4, 0, "WEST") }

      context "does not change position" do
        its(:position) { is_expected.to eq [4, 0] }
      end

      its(:direction) { is_expected.to eq "SOUTH" }
    end
  end

  describe "#right" do
    subject { toy_robot.right }

    context "when facing NORTH" do
      before { toy_robot.place(1, 2, "NORTH") }

      context "does not change position" do
        its(:position) { is_expected.to eq [1, 2] }
      end

      its(:direction) { is_expected.to eq "EAST" }
    end

    context "when facing EAST" do
      before { toy_robot.place(1, 4, "EAST") }

      context "does not change position" do
        its(:position) { is_expected.to eq [1, 4] }
      end

      its(:direction) { is_expected.to eq "SOUTH" }
    end

    context "when facing SOUTH" do
      before { toy_robot.place(3, 2, "SOUTH") }

      context "does not change position" do
        its(:position) { is_expected.to eq [3, 2] }
      end

      its(:direction) { is_expected.to eq "WEST" }
    end

    context "when facing WEST" do
      before { toy_robot.place(4, 0, "WEST") }

      context "does not change position" do
        its(:position) { is_expected.to eq [4, 0] }
      end

      its(:direction) { is_expected.to eq "NORTH" }
    end
  end

  describe "#report" do
    before { toy_robot.place(1, 2, "WEST") }

    it "gives the position and direction as an array" do
      expect(toy_robot.report).to eq [1, 2, "WEST"]
    end
  end
end
