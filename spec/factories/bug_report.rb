FactoryBot.define do
  factory :bug_report do
    type { "BugReport" }
    title { "New bug report" }
    description { "A new bug report" }
    deadline { Date.today + 1.week }
    progress { "to_do" }
    task_pool { create(:task_pool) }
  end
end
