# frozen_string_literal: true

5.times do |index|
  User.find_or_create_by(email: "user_#{index}@example.com") do |user|
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.password = 'password'
  end
rescue ActiveRecord::RecordInvalid => e
  Rails.logger.debug e.message
end

%w[Personal Work Rest].each { |category| Category.find_or_create_by!(name: category) }

5.times do
  Event.create(
    name: Faker::Lorem.sentence(word_count: 2),
    datetime: Faker::Date.between(from: DateTime.now.prev_day, to: DateTime.now.next_day),
    category: Category.all.sample,
    user: User.all.sample
  )
end
