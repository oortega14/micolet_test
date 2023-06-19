# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    answer { Faker::Lorem.sentence }
    association :user
    association :question
  end
end
