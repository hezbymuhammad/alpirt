require "rails_helper"

RSpec.describe SleepHistory, type: :model do
  let!(:incompleted) { create_list(:sleep_history, 3) }
  let!(:completed) { create_list(:sleep_history, 2, :completed) }

  describe ".incompleted" do
    it "return incompleted sleep history" do
      expect(described_class.incompleted).to eq(incompleted)
    end
  end

  describe ".completed" do
    it "return completed sleep history" do
      expect(described_class.completed).to eq(completed)
    end
  end

  describe "validations" do
    it "validate presence of clock in" do
      rec = described_class.new
      rec.save

      expect(rec.errors).to be_present
    end
  end

  describe "#calculate_duration" do
    it "after create" do
      rec = create :sleep_history, :completed

      expect(rec.duration).to be_present
    end

    it "after save" do
      rec = create :sleep_history

      expect(rec.duration).not_to be_present

      rec.clock_out = DateTime.now
      rec.save

      expect(rec.duration).to be_present
    end
  end

end
