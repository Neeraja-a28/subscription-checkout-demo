class OrderMailer < ApplicationMailer
	def confirmation_email(order)
		@order = order
		@user = User.find_by(id: @order.user_id)

		mail(to: @user.email, subject: "Order Confirmation")
	end
end
