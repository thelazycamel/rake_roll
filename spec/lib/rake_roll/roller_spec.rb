require "spec_helper"

describe RakeRoll::Roller do

  let(:roller) { RakeRoll::Roller.new }

  it "Should check the current version" do
    expect(roller.current_version).to eq(RakeRoll::VERSION)
  end

  it "Should accept a new version" do
    expect(roller.new_version).to eq(RakeRoll::VERSION)
    roller.new_version = "3.0.0"
    expect(roller.new_version).to eq("3.0.0")
  end 

  it "Should Roll out the changes" do
    roller.should_receive("system").with("git log #{RakeRoll::VERSION}..#{roller.current_branch} --pretty=format:'%s'")
    roller.should_receive("system").with("git push origin #{roller.current_branch}")
    roller.push
  end

end
