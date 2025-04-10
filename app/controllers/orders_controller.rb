class OrdersController < ApplicationController
	def new
		@subscription = Subscription.find(params[:subscription_id])
		@headsets = Headset.all
		@order = Order.new(subscription: @subscription)
	end

	def create
  		@order = Order.new(order_params)
  		@order.subscription_id = params[:subscription_id]
  		@order.headset_id = params[:headset_id] if params[:headset_id].present?
  		@order.user = current_user
  		@order.total_amount = calculate_total(@order)

  		@subscription = Subscription.find(@order.subscription_id)
  		@headsets = Headset.all

  		line_items = [{
  			price_data: {
  				currency: 'usd',
  				product_data: {
  					name: @order.subscription.name
  				},

  				unit_amount: (@order.subscription.price * 100).to_i
  			},
  			quantity: 1
  		}]

  		if @order.headset.present?

  			line_items << {
  				price_data: {
  					currency: 'usd',
  					product_data: {
  						name: @order.headset.name
  					},
  					unit_amount: (@order.headset.price * 100).to_i
  				},
  				quantity: 1
  			}
  		end

  		# using Checkout Session we can pay for one-time purchases or subscription

  		@session = Stripe::Checkout::Session.create({
  			payment_method_types: ['card'],
  			line_items: line_items,
  			mode: 'payment',
  			success_url: root_url,
  			cancel_url: root_url
  		})

  		@order.stripe_session_id = @session.id

  		if @order.save 
  			puts "Order details: #{@order.inspect}"
  			puts "Stripe Checkout Session created: #{@session.id}"

  			if @order.paid?
  				OrderConfirmationJob.perform_now(@order)
  			else
  				IncompleteCheckoutReminderJob.perform_now(@order)
  			end

			redirect_to subscriptions_path, notice: 'Order created successfully.'
		
  		else 
  			render :new
  		end

	end

	def show
		@order = Order.find(params[:id])
	end

	private
	def order_params
		params.require(:order).permit(:headset_id, :paid)
	end


	def calculate_total(order)
    	total = order.subscription.price
    	total += order.headset.price if order.headset
    	total
  	end

  	

end
