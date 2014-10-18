module Vorm
  class Model
    def self.reset
      @table = nil
      @fields = nil
    end
  end
end

describe Vorm::Model do
  context "class methods" do
    subject { Vorm::Model }

    describe ".table" do
      before { subject.reset }

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

    describe ".field" do
      before { subject.reset }

      it { is_expected.to respond_to(:field) }

      it "raises when name is not string" do
        expect { subject.field(:email) }
        .to raise_error(ArgumentError, "Field name must be a string")
      end

      it "sets the field correctly" do
        expect { subject.field('email') }
        .to change(subject, :fields)
      end


      it "ignores duplicates" do
        subject.field('email')
        subject.field('email')
        expect(subject.fields).to eq(Set.new(['email']))
      end
    end

    describe ".fields" do
      before { subject.reset }

      it { is_expected.to respond_to(:fields) }

      it "gets fields when only one set" do
        subject.field('email')
        expect(subject.fields).to eq(Set.new(['email']))
      end

      it "gets the fields when multiple set" do
        subject.field('email')
        subject.field('dob')
        expect(subject.fields).to eq(Set.new(['email', 'dob']))
      end
    end
  end
end

