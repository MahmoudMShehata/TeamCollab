class Task < ApplicationRecord
  belongs_to :task_pool
  has_and_belongs_to_many :users
end
