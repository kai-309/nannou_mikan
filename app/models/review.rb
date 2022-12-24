class Review < ApplicationRecord
  belongs_to :customer

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :rating, -> {order(rating: :desc)}

  validates :rating, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true
end