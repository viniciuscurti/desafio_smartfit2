class AddDetailsToLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :street, :string
    add_column :locations, :region, :string
    add_column :locations, :city_name, :string
    add_column :locations, :state_name, :string
    add_column :locations, :uf, :string
  end
end
