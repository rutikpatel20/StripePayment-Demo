class Product < ApplicationRecord
  validates :name, :price, presence: true

  # Convert object into name if we write direct product instead of product.name still it gives product name properly
  def to_s
    name
  end
end
