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
end
