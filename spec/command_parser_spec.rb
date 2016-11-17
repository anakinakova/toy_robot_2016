require "spec_helper"

describe ToyRobot::CommandParser do
  subject { ToyRobot::CommandParser.call(command_string) }

  describe "PLACE" do
    context "with whitespace" do
      let(:command_string) { " \tPLACE  2 \t,  3 ,\tSOUTH\t" }

      it { is_expected.to eq ["place", 2, 3, "SOUTH"] }
    end
  end
  
  describe "MOVE" do
    context "with whitespace" do
      let(:command_string) { " \tMOVE  \t" }

      it { is_expected.to eq ["move"] }
    end
  end

  describe "LEFT" do
    context "with whitespace" do
      let(:command_string) { " \tLEFT  \t" }

      it { is_expected.to eq ["left"] }
    end
  end
  
  describe "RIGHT" do
    context "with whitespace" do
      let(:command_string) { " \tRIGHT  \t" }

      it { is_expected.to eq ["right"] }
    end
  end
  
  describe "REPORT" do
    context "with whitespace" do
      let(:command_string) { " \tREPORT  \t" }

      it { is_expected.to eq ["report"] }
    end
  end
end
