class CreateMovies < ActiveRecord::Migration[8.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.text :note
      t.integer :status   # defaults live in the model: enum ..., default:
      t.integer :priority
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
