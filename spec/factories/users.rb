# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    teamleader { false }
  end

  factory :team_leader, parent: :user do
    teamleader { true }
  end
end
