# frozen_string_literal: true

FactoryBot.define do
  factory :feature_request do
    type { 'FeatureRequest' }
    title { 'New feature request' }
    description { 'A new feature request' }
    deadline { Time.zone.today + 2.weeks }
    progress { 'to_do' }
    task_pool { create(:task_pool) }
  end
end
