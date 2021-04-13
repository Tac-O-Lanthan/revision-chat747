class Room < ApplicationRecord
  has_secure_password
  with_options presence: true do
    validates :room_name
    validates :password, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?[0-9])[a-zA-Z0-9]{6,}\z/ }
  end
  has_many :room_users
  has_many :users, through: :room_users
end
