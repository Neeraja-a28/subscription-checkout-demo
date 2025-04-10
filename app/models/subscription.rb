class Subscription < ApplicationRecord
	validates :name, :price, :interval, presence: true	
end
