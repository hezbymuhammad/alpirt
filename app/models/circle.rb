class Circle < ApplicationRecord
  belongs_to :user
  belongs_to :following, class_name: "User"

  enum :status, { requested: 0, accepted: 1, rejected: 2, blocked: 3 }

  scope :accepted, -> { where(status: :accepted) }
end
