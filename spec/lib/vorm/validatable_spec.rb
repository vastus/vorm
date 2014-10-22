require 'byebug'

module Vorm
  module Validatable
    class ValidationError
      def clear_all
        @errors = Hash.new { |k, v| k[v] = [] }
      end
    end
  end
end

class Valid
  include Vorm::Validatable

  def self.reset!
    @validators = nil
  end
end

describe Vorm::Validatable do
  before { Valid.reset! }

  context "class methods" do
    subject { Valid }

    describe ".validates" do
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

  context "instance methods" do
    subject { Valid.new }

    before { subject.errors.clear_all }

    describe ".validate!" do
      it { is_expected.to respond_to(:validate!) }

      it "adds errors when invalid" do
        Valid.validates("email") { true }
        expect { subject.validate! }.to change { subject.errors.on("email").length }.by(1)
      end

      it "adds the validation messages to errors for the right field" do
        Valid.validates("email") { "not valid" }
        subject.valid?
        expect(subject.errors.on("email")).to eq(["not valid"])
      end

      it "adds validation messages to each field when invalid" do
        Valid.validates("email") { "required" }
        Valid.validates("email") { "not valid" }
        Valid.validates("password") { "too short" }
        subject.validate!
        expect(subject.errors.on("email").length).to be(2)
        expect(subject.errors.on("password").length).to be(1)
        expect(subject.errors.on("email")).to eq(["required", "not valid"])
        expect(subject.errors.on("password")).to eq(["too short"])
      end
    end

    describe ".valid?" do
      it { is_expected.to respond_to(:valid?) }

      it "calls .validate!" do
        expect(subject).to receive(:validate!)
        subject.valid?
      end

      it "calls .errors.empty?" do
        expect(subject.errors).to receive(:empty?)
        subject.valid?
      end

      it "returns true when no validations" do
        expect(subject).to be_valid
      end

      it "returns true when validations pass" do
        Valid.validates("email") { nil }
        expect(subject).to be_valid
      end

      it "returns false when validations fail" do
        Valid.validates("email") { "required" }
        expect(subject).not_to be_valid
      end
    end
  end
end

