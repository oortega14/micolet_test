# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    question { Faker::Lorem.sentence }
    position { Faker::Number.between(from: 1, to: 10) }
    association :survey
  end
end
