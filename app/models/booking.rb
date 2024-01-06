class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  belongs_to :show_timing

  validates :seat_number, presence: true, uniqueness: true
end
