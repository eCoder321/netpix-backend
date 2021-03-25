class CreateLists < ActiveRecord::Migration[6.1]
  def change
    create_table :lists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, foreign_key: true
      t.references :show, foreign_key: true

      t.timestamps
    end
  end
end
