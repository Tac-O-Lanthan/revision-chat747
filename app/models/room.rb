class Room < ApplicationRecord
  has_secure_password
  with_options presence: true do
    validates :room_name
    validates :password_digest, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?[0-9])[a-zA-Z0-9]{6,}\z/ }
  end
end
