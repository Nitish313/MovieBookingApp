class BookingsController < ApplicationController
  before_action :user_signed_in?
  before_action :find_movie_and_show_timing, except: %i[my_bookings destroy]
  before_action :find_booking, :is_owner, only: :destroy

  def new
    @booking = Booking.new
    @available_seats = (1..100).to_a - Booking.pluck(:seat_number)
  end

  def create
    updated_params = prepare_params(booking_params[:seat_number])
    Booking.upsert_all(updated_params)
  end

  def my_bookings
    @my_bookings = current_user&.bookings.order(movie_id: :asc)
  end

  def destroy
    if @booking.present?
      @booking.destroy
      flash[:notice] = 'Booking cancelled'
    else
      flash[:alert] = 'Something went wrong'
    end

    redirect_to my_bookings_path
  end

  private
  def booking_params
    params.permit(seat_number: [])
  end

  def find_movie_and_show_timing
    @movie = Movie.find(params[:movie_id])
    @show_timing = ShowTiming.find(params[:show_timing_id])
  end

  def prepare_params(seat_numbers)
    seat_numbers.map do |seat_number|
      { seat_number:, movie_id: @movie.id, show_timing_id: @show_timing.id, user_id: current_user.id }
    end
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def is_owner
    unless @booking.user == current_user
      flash[:alert] = 'You do not have appropriate access'
      redirect_to my_bookings_path
    end
  end
end
