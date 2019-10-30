# frozen_string_literal: true

class AddDetailToTimers < ActiveRecord::Migration[5.2]
  def change
    add_column :timers, :detail, :text
  end
end
