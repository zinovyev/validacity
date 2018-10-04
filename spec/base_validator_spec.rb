RSpec.describe Validacity::BaseValidation do
  describe "#validate" do
    let(:email_validation) { Validacity.find_validation(:email).new(user) }

    context "valid model" do
      let(:user) { User.new(name: "Leo", email: "leo@example.com") }
      it "should return true" do
        expect(email_validation.validate).to eq(true)
      end
    end

    context "invalid model" do
      let(:user) { User.new(name: "Leo", email: "leo@example") }
      it "should return true" do
        expect(email_validation.validate).to eq(false)
      end
    end
  end
end
