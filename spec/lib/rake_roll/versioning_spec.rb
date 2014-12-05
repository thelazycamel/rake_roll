describe RakeRoll::Versioning do


  it "should validate the version" do
    expect(RakeRoll::Versioning.new("1").current_version).to eq(false)
  end 

  context "Dealing with 3 levels" do

    let(:version) { RakeRoll::Versioning.new("1.0.0") }

    it "#bump should => 1.0.0 to 1.0.1" do
      expect(version.bump).to eq("1.0.1")
    end

    it "#pre should => 1.0.0 to 1.0.0a" do
      expect(version.pre).to eq("1.0.0a")
    end

    it "#minor should => 1.0.0 to 1.1.0" do
      expect(version.minor).to eq("1.1.0")
    end

    it "#major should => 1.0.0 to 2.0.0" do
      expect(version.major).to eq("2.0.0")
    end

  end

  context "Dealing with 2 levels" do

    let(:version) { RakeRoll::Versioning.new("1.0") }

    it "#bump should => 1.0 to 1.1" do
      expect(version.bump).to eq("1.1")
    end

    it "#pre should => 1.0 to 1.0a" do
      expect(version.pre).to eq("1.0a")
    end

    it "#minor should => 1.0 to 1.1" do
      expect(version.minor).to eq("1.1")
    end

    it "#major should => 1.0 to 2.0" do
      expect(version.major).to eq("2.0")
    end

  end

  context "Other versioning cases" do

    it "#bump should => 1.0a to 1.1" do
      expect(RakeRoll::Versioning.new("1.0a").bump).to eq("1.1")
    end

    it "#major should => 1.5a to 2.0" do
      expect(RakeRoll::Versioning.new("1.5a").major).to eq("2.0")
    end

    it "#minor should => 1.9a to 1.10" do
      expect(RakeRoll::Versioning.new("1.9a").minor).to eq("1.10")
    end

    it "#pre should => 1.5a to 1.5b" do
      expect(RakeRoll::Versioning.new("1.5a").pre).to eq("1.5b")
    end

    it "#bump should => 1.0.0a to 1.0.1" do
      expect(RakeRoll::Versioning.new("1.0.0a").bump).to eq("1.0.1")
    end

    it "#major should => 1.5.5a to 2.0.0" do
      expect(RakeRoll::Versioning.new("1.5.5a").major).to eq("2.0.0")
    end

    it "#minor should => 1.5.5a to 1.6.0" do
      expect(RakeRoll::Versioning.new("1.5.5a").minor).to eq("1.6.0")
    end

    it "#pre should => 1.5.5a to 1.5.5b" do
      expect(RakeRoll::Versioning.new("1.5.5a").pre).to eq("1.5.5b")
    end

    it "#bump should => 1.10 to 1.11" do
      expect(RakeRoll::Versioning.new("1.10").bump).to eq("1.11")
    end

    it "#bump should => 1.1.10 to 1.1.11" do
      expect(RakeRoll::Versioning.new("1.1.10").bump).to eq("1.1.11")
    end

    it "#minor should => 1.10.1 to 1.11.11" do
      expect(RakeRoll::Versioning.new("1.10.1").minor).to eq("1.11.0")
    end

    it "#major should => 10.1.0 to 11.0.0" do
      expect(RakeRoll::Versioning.new("10.1.0").major).to eq("11.0.0")
    end

    it "#major should => 10.1 to 11.0" do
      expect(RakeRoll::Versioning.new("10.1").major).to eq("11.0")
    end

  end

end
