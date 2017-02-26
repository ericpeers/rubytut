class Article < ApplicationRecord
  has_many :comments,
           dependent: :destroy #chain the delete.
  validates :title, presence: true,
            length: {minimum: 5}
  validates :text, presence: true,
            length: {minimum: 5}

end
