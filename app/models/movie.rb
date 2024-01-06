class Movie < ApplicationRecord
  serialize :show_timings, Array
  has_many :bookings
end
