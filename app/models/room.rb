class Room < ApplicationRecord
has_many :user_rooms, foreign_key: 'Room_id'
has_many :users, through: :user_rooms
has_many :chats, foreign_key: 'Room_id'
end
