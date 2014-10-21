describe Vorm::Model do
  context "class methods" do
    subject { Vorm::Model }

    it "should include Persistable" do
      expect(subject.included_modules).to include(Vorm::Persistable)
    end
  end
end

