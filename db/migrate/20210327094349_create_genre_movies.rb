class CreateGenreMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :genre_movies do |t|
      t.references :movie, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.references :show, foreign_key: true

      t.timestamps
    end
  end
end
