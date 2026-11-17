class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title , null: false
      t.text :description
      t.integer :status
      t.datetime :due_date
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tasks, :title, unique: true
  end
end
