# frozen_string_literal: true

FactoryBot.define do
  factory :survey do
    name { Faker::Lorem.word }
    language { %w[es en fr de].sample }
  end
end
