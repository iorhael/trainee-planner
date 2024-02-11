# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { Faker::Lorem.sentence(word_count: 2) }
    event_time { Faker::Time.between(from: DateTime.now + 1.minute, to: DateTime.now.days_since(7)) }
    category { association :category }
  end

  trait :with_descriprition do
    description { Faker::Lorem.paragraph }
  end

  trait :with_reminder_time do
    reminder_time { event_time - 1.hour }
  end
end
