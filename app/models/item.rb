class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :list
  has_many :votes
  has_many :comments
  mount_uploader :image, ImageUploader
end
