class CreateSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.decimal :price
      t.string :interval

      t.timestamps
    end
  end
end
