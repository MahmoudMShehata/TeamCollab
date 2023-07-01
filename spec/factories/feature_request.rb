FactoryBot.define do
  factory :feature_request do
    type { "FeatureRequest" }
    title { "New feature request" }
    description { "A new feature request" }
    deadline { Date.today + 2.weeks }
    progress { "to_do" }
    task_pool { create(:task_pool) }
  end
end
