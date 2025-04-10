class IncompleteCheckoutReminderJob < ApplicationJob
  queue_as :default

  def perform(order)
    order = Order.find(order.id)
    puts "Sending reminder email for incomplete checkout: #{order.id}"
    return if order.nil?

    ReminderMailer.reminder_email(order).deliver_now unless order.paid?
  end

end