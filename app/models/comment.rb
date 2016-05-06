class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  belongs_to :list
  validates :content, presence: true
  validates :user_id, presence: true
  validates :list_id, presence: true
end
