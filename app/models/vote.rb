class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  validates :item_id, presence: true
  validates :user_ip, presence: true, if: ":current_user.nil?"
  validates :user_id, presence: true, unless: ":signed_in?"
  validates :vot, presence: true, inclusion: { in: %w(up down)}
end
