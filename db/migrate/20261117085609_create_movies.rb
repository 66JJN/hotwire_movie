class CreateMovies < ActiveRecord::Migration[8.1]
  def change
    create_table :movies do |t|
      t.references :category, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :year
      t.text :note
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :movies, :status
  end
end
