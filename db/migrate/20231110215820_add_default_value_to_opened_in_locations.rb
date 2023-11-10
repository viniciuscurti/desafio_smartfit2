class AddDefaultValueToOpenedInLocations < ActiveRecord::Migration[7.1]
  def change
    change_column_default :locations, :opened, from: nil, to: false
  end
end
