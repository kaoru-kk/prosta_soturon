class AddTotalToTimers < ActiveRecord::Migration[5.2]
  def change
    add_column :timers, :total, :integer
  end
end
