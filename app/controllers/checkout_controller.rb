class CheckoutController < ApplicationController
  def create
    product = Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      mode: "payment",
      # Remove the payment_method_types parameter
      # to manage payment methods in the Dashboard
      customer: current_user.stripe_customer_id,
      payment_method_types: ["card"],
      line_items: [{
        price: product.stripe_price_id,
        quantity: 1,
      }],
      success_url: root_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: root_url,
    })
    respond_to do |format|
      format.js
    end
  end
end
