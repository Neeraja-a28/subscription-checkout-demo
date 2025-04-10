class SubscriptionsController < ApplicationController
	def index
		@subscriptions = Subscription.all
		@user_orders = current_user.orders.includes(:headset)
		@orders_by_subscription = @user_orders.index_by(&:subscription_id)
	end

	def show
		@subscription = Subscription.find(params[:id])
	end

	def new
		@subscription = Subscription.new
	end

	def create
		@subscription = Subscription.create(subscription_params)

		if @subscription.save
			redirect_to subscriptions_path, notice: 'Subscription created successfully.'
		else
			render :new
		end
	end

	private
	def subscription_params
		params.require(:subscription).permit(:name, :price, :interval)
	end
end
