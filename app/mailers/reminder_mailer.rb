class ReminderMailer < ApplicationMailer

	def reminder_email(order)
		@order = order
		@user = User.find_by(id: @order.user_id)

		mail(to: @user.email, subject: "Reminder Mailer")
	end
end