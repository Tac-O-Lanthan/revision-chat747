class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :email, uniqueness: true
    validates :password, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?[0-9])[a-zA-Z0-9]{6,}\z/ }
    validates :user_name, uniqueness: true
    validates :full_name
    validates :corp_name
  end
  has_many :room_users
  has_many :users, through: :room_users
end

  # 正規表現
  # /  /    ;正規表現
  # \A \z   ;文頭と文末 （ == ^ $ ）
  # [ ]   ;文字クラス指定
  # ぁ-ん ァ-ン 一-龥 々 ヵ ヶ    ;全角かなカナ漢字
  # A-Z a-z 0-9   ;半角英数大小
  # +   ;直前の表現の繰り返し
  # .*?    ;「0回以上（*）」繰り返す「任意の文字列（.）」（最短一致）
  # {x, y} ;直前の文字列（文字クラス）がx回以上y回以下の繰り返し
  # ?=    ;肯定的先読み「hoge(?=huga)」 → hugaが直後に存在するhogeを検証する
  #       ;(?=.*[~]) → 「[~]に一致する文字列」が直後に存在する「任意の文字列0文字以上」
  #       ;0文字＝空文字を含むので、複数の(?=.*[])を同時に検証できる