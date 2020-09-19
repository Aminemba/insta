class User < ApplicationRecord

has_many :posts, dependent: :destroy
has_many :likes
has_many :comments
has_many :bookmarks

validates :name, presence: true, length: {maximum: 50}



end
