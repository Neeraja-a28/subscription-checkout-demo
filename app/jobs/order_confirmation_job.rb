class OrderConfirmationJob < ApplicationJob
  queue_as :default

  def perform(order)
    order = Order.find(order.id)
    puts "perform order confirmation: #{order.id}"
    OrderMailer.confirmation_email(order).deliver_now
  end
end
