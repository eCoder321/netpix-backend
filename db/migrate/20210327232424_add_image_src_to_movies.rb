class AddImageSrcToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :image_src, :string
  end
end
