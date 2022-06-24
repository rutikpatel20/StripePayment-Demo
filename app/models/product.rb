class Product < ApplicationRecord
  validates :name, :price, presence: true

  # Convert object into name if we write direct product instead of product.name still it gives product name properly
  def to_s
    name
  end

  after_create do
    product = Stripe::Product.create(name: name)
    price = Stripe::Price.create(product: product, unit_amount: self.price, currency: "inr")
    update(stripe_product_id: product.id)
  end
end
