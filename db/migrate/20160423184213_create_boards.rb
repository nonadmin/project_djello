class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :title, :default => "Untitled"

      t.timestamps null: false
    end

    create_table :boards_users, id: false do |t|
      t.belongs_to :board, index: true
      t.belongs_to :user, index: true
    end
  end
end
