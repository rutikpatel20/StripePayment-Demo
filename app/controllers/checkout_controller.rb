class CheckoutController < ApplicationController
  def create
    product = Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      mode: "payment",
      # Remove the payment_method_types parameter
      # to manage payment methods in the Dashboard
      payment_method_types: ["card"],
      line_items: [{
        name: product.name,
        amount: product.price,
        currency: "usd",
        quantity: 1,
      }],
      success_url: root_url,
      cancel_url: root_url,
    })
    respond_to do |format|
      format.js
    end
  end
end
