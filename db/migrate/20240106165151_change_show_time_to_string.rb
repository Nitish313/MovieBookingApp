class ChangeShowTimeToString < ActiveRecord::Migration[7.0]
  def up
    change_column :show_timings, :show_time, :string
  end

  def down
    change_column :show_timings, :show_time, :datetime
  end
end
