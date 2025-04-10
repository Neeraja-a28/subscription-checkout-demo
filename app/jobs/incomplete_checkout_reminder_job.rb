class IncompleteCheckoutReminderJob < ApplicationJob
  queue_as :default

  def perform(order)
    puts "perform incomplete checkout reminder confirmation"
    order = Order.where(id: order.id, paid: false).last
    ReminderMailer.reminder_email(order).deliver_now unless order.paid?
  end

end