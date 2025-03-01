class SleepHistory < ApplicationRecord
  belongs_to :user

  validates :clock_in, presence: true
  validate :validate_last_sleep_clock, on: :create, if: :clock_out_blank?
  validate :validate_sleep_clock, if: :clock_out_present?

  before_create :calculate_duration, if: :clock_out_present?
  before_update :calculate_duration, if: :clock_out_changed?

  scope :incompleted, -> { where(clock_out: nil) }
  scope :completed, -> { where.not(clock_out: nil) }

  private

  def validate_sleep_clock
    if clock_out < clock_in
      return errors.add(:clock_out_time, "clock out must be after clock in")
    end
  end

  def validate_last_sleep_clock
    if SleepHistory.incompleted.present?
      return errors.add(:clock_out_time, "please clock out previous session first")
    end
  end

  def clock_out_blank?
    clock_out.blank?
  end

  def clock_out_present?
    clock_out.present?
  end

  def calculate_duration
    self.duration = (clock_out - clock_in).floor
  end
end
