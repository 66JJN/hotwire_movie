# Movies replace the workshop's tasks. The block lets this migration roll back.
class DropTasks < ActiveRecord::Migration[8.1]
  def change
    drop_table :tasks do |t|
      t.references :category, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :status, null: false, default: 0
      t.datetime :due_date

      t.timestamps
    end
  end
end
