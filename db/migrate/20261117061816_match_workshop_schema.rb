# Align the schema with the workshop README (Step 1): uniqueness of category
# names is enforced by the model validation only, and task titles may repeat.
class MatchWorkshopSchema < ActiveRecord::Migration[8.1]
  def change
    remove_index :tasks, :title, unique: true
    remove_index :categories, :name, unique: true

    change_column_null :tasks, :title, true
    change_column_null :categories, :name, true
  end
end
