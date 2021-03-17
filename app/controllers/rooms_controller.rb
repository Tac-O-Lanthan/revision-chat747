class RoomsController < ApplicationController
  # index以外は全てログイン必須。ログイン機能完成までコメントアウト
  # before_action :authenticate_user!, except: [:index]
  
  # ホームページ
  def index
    @rooms = Room.all.includes(:user)
  end

  # roomsコントローラーのshowアクションは、入室のためのパスワード入力画面表示として使う
  def show
  end

  # ルーム作成画面
  def new
    @room = Room.new
  end

  # 作成したルームの保存
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
