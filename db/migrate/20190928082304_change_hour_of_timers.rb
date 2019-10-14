# frozen_string_literal: true

class ChangeHourOfTimers < ActiveRecord::Migration[5.2]
  def self.up
    change_column :timers, :hour, :integer, default: 0
    change_column :timers, :min, :integer, default: 0
    change_column :timers, :sec, :integer, default: 0
  end

  def self.down
    change_column :timers, :hour, :integer
    change_column :timers, :min, :integer
    change_column :timers, :sec, :integer
  end
end
