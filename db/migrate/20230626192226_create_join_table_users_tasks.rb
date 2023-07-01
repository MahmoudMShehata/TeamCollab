# frozen_string_literal: true

class CreateJoinTableUsersTasks < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :tasks do |t|
      t.index %i[user_id task_id]
      t.index %i[task_id user_id]
    end
  end
end
