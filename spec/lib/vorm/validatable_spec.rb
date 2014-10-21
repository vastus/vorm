require 'byebug'
class Valid
  include Vorm::Validatable

  def self.reset
    @validators = nil
  end
end

describe Vorm::Validatable do
  context "class methods" do
    subject { Valid }

    describe ".validates" do
      before { subject.reset }

      it { is_expected.to respond_to(:validates) }

      it "raises argument error when given arg is not string" do
        expect { subject.validates(:email) }
        .to raise_error(ArgumentError, "Field name must be a string")
      end

      it "raises argument error when no block given" do
        expect { subject.validates("email") }
        .to raise_error(ArgumentError, "You must provide a block")
      end

      it "stores a validator" do
        subject.validates("email") { "required" }
        expect(subject.instance_variable_get('@validators')["email"].length).to be(1)
      end

      it "stores multiple validators" do
        subject.validates("email") { "required" }
        subject.validates("email") { "not valid" }
        subject.validates("password") { "required" }
        expect(subject.instance_variable_get('@validators')["email"].length).to be(2)
        expect(subject.instance_variable_get('@validators')["password"].length).to be(1)
      end
    end
  end 
end

