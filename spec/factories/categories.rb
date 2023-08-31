# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { %w[Personal Work Rest].sample }
  end

  trait :personal do
    name { 'Personal' }
  end

  trait :work do
    name { 'Work' }
  end

  trait :rest do
    name { 'Rest' }
  end
end
