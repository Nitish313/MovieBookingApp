class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :seat_number
      t.references :movie, null: false, foreign_key: true
      t.datetime :showtime

      t.timestamps
    end
  end
end
