class Review < ApplicationRecord
  validates :rating, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true

  belongs_to :customer
end
