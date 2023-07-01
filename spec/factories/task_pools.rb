FactoryBot.define do
  factory :task_pool do
    name { "Task Pool" }
    team_leader { association(:user) }
    created_at { Time.current }
    updated_at { Time.current }
  end
end