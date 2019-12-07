class Message < ApplicationRecord
  belongs_to :user1, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :user2, class_name: 'User', foreign_key: 'receiver_id'
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
end
