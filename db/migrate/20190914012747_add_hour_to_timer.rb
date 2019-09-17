class AddHourToTimer < ActiveRecord::Migration[5.2]
  def change
    add_column :timers, :hour, :integer
    add_column :timers, :min, :integer
    add_column :timers, :sec, :integer

  end
end
