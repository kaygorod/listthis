class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :list
  mount_uploader :image, ImageUploader
end
