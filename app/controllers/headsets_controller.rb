class HeadsetsController < ApplicationController
	def new
		@headset = Headset.new
	end

	def create
		@headset = Headset.create(headset_params)

		if @headset.save
			redirect_to subscriptions_path, notice: 'Headset created successfully.'
		else
			render :new
		end
	end

	private
	def headset_params
		params.require(:headset).permit(:name, :price, :description)
	end
end