# frozen_string_literal: true

5.times do |i|
  User.create_or_find_by!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "user_#{i}@example.com",
    password: 'password'
  )
rescue ActiveRecord::RecordInvalid => e
  Rails.logger.debug e.message
end
