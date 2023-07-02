# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :task_pools, foreign_key: 'team_leader_id', dependent: :destroy, inverse_of: :team_leader
  has_and_belongs_to_many :tasks
  has_many :assigned_tasks, through: :tasks_users, source: :task
  has_and_belongs_to_many :assigned_task_pools, class_name: 'TaskPool', join_table: 'tasks_users',
                                                association_foreign_key: 'task_pool_id'

  def total_tasks_count
    task_pools.sum { |pool| pool.tasks.count }
  end

  def overdue_tasks
    Task.joins(:task_pool).where.not(progress: 'done')
        .where(task_pools: { team_leader_id: id })
        .or(Task.joins(:task_pool).where.not(progress: 'done').where(task_pools: { id: task_pool_ids }))
  end

  def done_tasks
    Task.joins(:task_pool).where(progress: 'done',
                                 task_pools: { team_leader_id: id }).or(Task.joins(:task_pool)
                          .where(progress: 'done', task_pools: { id: task_pool_ids }))
  end
end
