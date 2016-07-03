class Item < ActiveRecord::Base
  resourcify
  belongs_to :user
  belongs_to :list
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader
  validates :list_id, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :image, presence: true
  validates :rating, presence: true
end
