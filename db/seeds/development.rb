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
