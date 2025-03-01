require 'rails_helper'

RSpec.describe Circle, type: :model do
  describe ".active" do
    let(:requested_circles) { create_list(:circle, 3, status: :requested) }
    let(:accepted_circles) { create_list(:circle, 3, status: :accepted) }

    it "return accepted circle" do
      requested_circles
      accepted_circles

      expect(described_class.accepted).to eq(accepted_circles)
    end
  end

  describe "#validate_following" do
    it "cannot self follow" do
      user = create :user
      circle = described_class.new user: user, following: user

      expect(circle).to_not be_valid
    end
  end
end
