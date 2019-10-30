# frozen_string_literal: true

class AddHourToTimer < ActiveRecord::Migration[5.2]
  def change
    add_column :timers, :hour, :integer, default: 0
    add_column :timers, :min, :integer, default: 0
    add_column :timers, :sec, :integer, default: 0
  end
end
