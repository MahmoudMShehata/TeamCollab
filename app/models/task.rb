class Task < ApplicationRecord
  # enum progress: [:to_do, :in_progress, :done]

  validates :progress, presence: true

  belongs_to :task_pool
  has_and_belongs_to_many :users
end
