class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :comment, presence: true
end
