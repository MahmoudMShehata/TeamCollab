# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email       { Faker::Internet.email  }
    password    { 111111  }
  end
end
