# frozen_string_literal: true

FactoryBot.define do
  factory :preference do
    name { Faker::Lorem.word }
    internal_key { Faker::Lorem.word }
    association :user
  end
end
