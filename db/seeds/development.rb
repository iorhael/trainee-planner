# frozen_string_literal: true

users = 5.times.map do |index|
  User.find_or_create_by(email: "user_#{index}@example.com") do |user|
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.password = 'password'
  end
rescue ActiveRecord::RecordInvalid => e
  Rails.logger.debug e.message
end

categories = %w[Personal Work Rest].map { |category| Category.find_or_create_by!(name: category) }

5.times do
  Event.create!(
    name: Faker::Lorem.sentence(word_count: 2),
    event_time: Faker::Time.between(from: DateTime.now + 1.minute, to: DateTime.now.days_since(7)),
    category: categories.sample,
    user: users.sample
  )
end
