class RoomsController < ApplicationController
  
  def index
    @rooms = Room.all.includes(:user)
  end

  def new
  end

  def create
  end

end
