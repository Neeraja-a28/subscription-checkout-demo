class CreateHeadsets < ActiveRecord::Migration[8.0]
  def change
    create_table :headsets do |t|
      t.string :name
      t.decimal :price
      t.string :interval

      t.timestamps
    end
  end
end
