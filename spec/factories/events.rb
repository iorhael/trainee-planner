# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { 'Test event' }
    datetime { DateTime.now }
    user { association :user }
    category { association :category }
  end

  trait :with_descriprition do
    description { Faker::Lorem.paragraph }
  end

  trait :with_reminder_time do
    reminder_time { datetime.next_day }
  end
end
