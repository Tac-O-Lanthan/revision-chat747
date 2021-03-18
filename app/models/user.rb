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
end
