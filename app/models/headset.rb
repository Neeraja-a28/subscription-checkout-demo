class Headset < ApplicationRecord
	validates :name, :price, :description, presence: true	
end
