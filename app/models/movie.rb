class Movie < ApplicationRecord
  has_many :bookings
  has_many :show_timings
end
