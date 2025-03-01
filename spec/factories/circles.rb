FactoryBot.define do
  factory :circle do
    association :user
    association :following, factory: :user
  end
end
