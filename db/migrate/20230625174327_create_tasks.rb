# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :type, limit: 20
      t.string :title, limit: 255
      t.text :description
      t.datetime :deadline
      t.string :progress, limit: 20
      t.string :attachment, limit: 255

      t.timestamps
    end
  end
end
