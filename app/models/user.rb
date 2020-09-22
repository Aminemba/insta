class User < ApplicationRecord
  
has_many :posts, dependent: :destroy
has_many :bookmarks
has_many :comments, foreign_key: 'user_id'
has_many :likes, foreign_key: 'user_id'

  validates :name, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: /@/

has_secure_password
end


def self.search(term)
  if term
    where('name LIKE ?', "%#{term}%")
  else
    nil
  end


end
