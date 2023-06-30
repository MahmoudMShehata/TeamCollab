class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :task_pools, foreign_key: "team_leader_id"
  has_and_belongs_to_many :tasks
  has_many :assigned_tasks, through: :tasks_users, source: :task
  has_many :assigned_task_pools, through: :assigned_tasks, source: :task_pool, class_name: "TaskPool"
end
