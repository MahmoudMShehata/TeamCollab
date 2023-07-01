# frozen_string_literal: true

class AddTaskPoolToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :task_pool, null: false, foreign_key: true
  end
end
