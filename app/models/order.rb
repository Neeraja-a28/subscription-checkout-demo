class Order < ApplicationRecord
  belongs_to :user
  belongs_to :subscription
  belongs_to :headset, optional: true
end
