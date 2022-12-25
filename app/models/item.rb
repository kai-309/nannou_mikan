class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_details, dependent: :destroy
  has_many :comments
  has_many :reviews
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags

  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true
  validates :caption, presence: true
  validates :excluded_price, presence: true
  validates :is_status, inclusion: [true, false]

  def add_tax_price
    (self.excluded_price * 1.10).round
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/aseets/images/no_image.jpg')
      image.attach(io: File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width,height]).processed
  end

  def save_tags(tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      item_tag = Tag.find_or_create_by(name: new_name)
      self.tags << item_tag
    end
  end
end