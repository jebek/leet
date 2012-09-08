class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
