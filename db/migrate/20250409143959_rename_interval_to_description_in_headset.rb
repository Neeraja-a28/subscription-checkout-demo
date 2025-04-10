class RenameIntervalToDescriptionInHeadset < ActiveRecord::Migration[8.0]
  def change
    rename_column :headsets, :interval, :description
  end
end
