class Circle < ApplicationRecord
  belongs_to :user
  belongs_to :following, class_name: "User"
  validate :validate_following

  enum :status, { requested: 0, accepted: 1, rejected: 2, blocked: 3 }

  scope :accepted, -> { where(status: :accepted) }

  private

    def validate_following
      if user == following
        errors.add(:user, "cannot self follow")
        errors.add(:following, "cannot self follow")
      end
    end
end
