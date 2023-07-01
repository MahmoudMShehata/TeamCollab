# frozen_string_literal: true

FactoryBot.define do
  factory :marketing_campaign do
    type { 'MarketingCampaign' }
    title { 'New marketing campaign' }
    description { 'A new marketing campaign' }
    deadline { Time.zone.today + 3.weeks }
    progress { 'to_do' }
    task_pool { create(:task_pool) }
  end
end
