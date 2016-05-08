class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :board_id
      t.integer :position
      t.string :title
      t.string :description

      t.timestamps null: false
    end

    add_index :lists, [:board_id, :position], unique: true
  end
end
