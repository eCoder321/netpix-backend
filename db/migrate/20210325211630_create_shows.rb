class CreateShows < ActiveRecord::Migration[6.1]
  def change
    create_table :shows do |t|
      t.string :title
      t.string :overview
      t.string :last_air_date

      t.timestamps
    end
  end
end
