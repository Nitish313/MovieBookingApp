class AddShowTimingToBooking < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :show_timing, null: false, foreign_key: true
  end
end
