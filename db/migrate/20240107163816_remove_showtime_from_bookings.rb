class RemoveShowtimeFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :showtime, :datetime
  end
end
