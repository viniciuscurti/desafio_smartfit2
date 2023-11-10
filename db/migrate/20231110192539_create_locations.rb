class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :uuid
      t.string :title
      t.string :content
      t.boolean :opened
      t.string :mask
      t.string :towel
      t.string :fountain
      t.string :locker_room
      t.string :schedules

      t.timestamps
    end
  end
end
