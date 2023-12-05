class User < ApplicationRecord
  has_many :friends, foreign_key: "sender_id",dependent: :destroy
  has_many :posts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :status, { Add: 0, requested: 1, rejected: 2 }


  def check_user
    user_ids = []
    friends.accepted.each do |friend|
      user_ids<< friend.receiver_id
    end
    Friend.accepted.where(receiver_id: self.id).each do |friend|
      user_ids<< friend.user.id
    end
    User.all.where.not(id: user_ids)
  end
end
