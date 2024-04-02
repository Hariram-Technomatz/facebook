class Friend < ApplicationRecord
  belongs_to :user, foreign_key: "sender_id"
  enum :status, { pending: 0, accepted: 1, rejected: 2, cancelled: 3 }
  validates_uniqueness_of :receiver_id, scope: 'sender_id'

  def self.my_friends(user)
    users = []
    @friends = Friend.accepted.where(receiver_id: user.id)
    @friends.each do |friend|
      users<< friend&.user
    end
    user&.friends&.accepted.each do |friend|
      users<< User&.find_by_id(friend&.receiver_id)
    end
    users.uniq
  end
end
