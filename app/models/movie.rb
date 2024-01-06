class Movie < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :show_timings, dependent: :destroy

  validates :title, presence: true
  validates :genre, presence: true

  before_save ->(movie) { movie.title = movie.title.titleize }
  scope :latest_movies, -> { order(created_at: :desc) }
end
