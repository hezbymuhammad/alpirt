FactoryBot.define do
  factory :sleep_history do
    date = Faker::Date.between(from: 14.days.ago, to: Date.today)

    association :user
    clock_in { Faker::Time.between_dates(from: date, to: date, period: :night) }

    trait :completed do
      clock_out { Faker::Time.between_dates(from: date + 1, to: date + 1, period: :morning) }
      duration { Faker::Number.number(digits: 2) }
    end
  end
end
