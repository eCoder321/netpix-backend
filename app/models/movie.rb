class Movie < ApplicationRecord
    has_many :lists
    has_many :users, through: :lists
    has_many :genre_movies
    has_many :genres, through: :genre_movies
end
