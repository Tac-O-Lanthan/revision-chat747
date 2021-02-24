class RoomsController < ApplicationController
  
  def index
    @rooms = Room.all.includes(:user)
  end

  # roomsコントローラーのshowアクションは、入室のためのパスワード入力画面表示として使う
  def show
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def room_params
    params.require(:room).permit(:room_name, :password_digest)
  end

end
