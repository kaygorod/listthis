class List < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  has_many :items, dependent: :destroy
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader
  validates :title, presence: true
  validates :description, presence: true
  validates :image, presence: true
  extend FriendlyId
    friendly_id :title, use: :slugged
end
