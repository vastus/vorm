describe Vorm::Model do
  context "class methods" do
    subject { Vorm::Model }

    describe ".table" do
      it { is_expected.to respond_to(:table) }

      it "raises when name is not string" do
        expect { subject.table(:users) }
        .to raise_error(ArgumentError, "Table name must be a string")
      end

      it "sets the table correctly" do
        expect { subject.table('users') }
        .to change(subject, :table).to('users')
      end

      it "gets the table" do
        subject.table('users')
        expect(subject.table).to eq('users')
      end

      it "setting the table again does not change it (cached)" do
        subject.table('users')
        expect { subject.table('another table') }
        .not_to change(subject, :table)
      end
    end
  end
end

