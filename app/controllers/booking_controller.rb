class BookingController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @booking_pages, @bookings = paginate :bookings, :per_page => 10
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(params[:booking])
    if @booking.save
      flash[:notice] = 'Booking was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update_attributes(params[:booking])
      flash[:notice] = 'Booking was successfully updated.'
      redirect_to :action => 'show', :id => @booking
    else
      render :action => 'edit'
    end
  end

  def destroy
    Booking.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def add_booking
  end

  def cancel_booking
  end

  def list_bookings
  end

  def index
  end
end
