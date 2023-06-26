class CreateTaskPools < ActiveRecord::Migration[7.0]
  def change
    create_table :task_pools do |t|
      t.string :name
      t.integer :team_leader_id

      t.timestamps
    end
  end
end
