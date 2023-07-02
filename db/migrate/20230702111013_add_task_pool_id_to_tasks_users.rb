class AddTaskPoolIdToTasksUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks_users, :task_pool_id, :bigint
  end
end
