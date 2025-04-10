class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true
      t.references :headset, null: false, foreign_key: true
      t.decimal :total_amount
      t.boolean :paid

      t.timestamps
    end
  end
end
