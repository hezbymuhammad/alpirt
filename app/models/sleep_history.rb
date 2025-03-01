class SleepHistory < ApplicationRecord
  belongs_to :user

  validates :clock_in, presence: true

  before_create :calculate_duration, if: :clock_out_present?
  before_update :calculate_duration, if: :clock_out_changed?

  scope :incompleted, -> { where(clock_out: nil) }
  scope :completed, -> { where.not(clock_out: nil) }

  private

  def clock_out_present?
    clock_out.present?
  end

  def calculate_duration
    self.duration = (clock_out - clock_in).floor
  end
end
