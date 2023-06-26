class CreateJoinTableTaskPoolsUsers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :task_pools, :users, table_name: :team_members do |t|
      t.index [:task_pool_id, :user_id]
      t.index [:user_id, :task_pool_id]
    end
  end
end
