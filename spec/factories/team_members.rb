# frozen_string_literal: true

FactoryBot.define do
  factory :team_member do
    task_pool
    user
  end
end
