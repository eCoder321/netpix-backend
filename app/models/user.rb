class User < ApplicationRecord
    has_many :lists
    has_many :movies, through: :lists
    has_many :shows, through: :lists 
end
