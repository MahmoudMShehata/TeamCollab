FactoryBot.define do
  factory :task do
    title { "Task Title" }
    description { "Task description" }
    deadline { Time.current + 7.days }
    progress { "in_progress" }
    task_pool

    attachment { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'attachment.txt'), 'text/plain') }
  end
end