RSpec.describe Validacity::BaseValidation do
  describe "#validate" do
    context "valid model" do
      let(:user) do
        user = User.new(name: "Leo", email: "leo@example.com")
        user.extend(Validacity::Validatable)
        user.validacity_validations << :email
        user
      end

      it "should be valid" do
        expect(user.valid?).to eq(true)
      end
    end

    context "invalid model" do
      let(:user) do
        user = User.new(name: "Leo", email: "leo@example")
        user.extend(Validacity::Validatable)
        user.validacity_validations << :email
        user
      end

      it "should be invalid" do
        expect(user.valid?).to eq(false)
      end
    end

    context "defined by class methods" do
      let(:user) do
        User.include(Validacity::Validatable)
        User.validacity_validations << :email
        user = User.new(name: "Leo", email: "@example.com")
        user
      end

      it "should be valid" do
        expect(user.invalid?).to eq(true)
      end
    end
  end
end
