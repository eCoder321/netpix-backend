class GenreMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :genre
  # belongs_to :show
end
