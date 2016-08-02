class List < ActiveRecord::Base
  resourcify
  belongs_to :user
  validates :user_id, presence: true
  has_many :items, dependent: :destroy
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader
  validates :title, presence: true
  validates :description, presence: true
  validates :image, presence: true
  #подключение красивого адреса, и включение поиска не только по имени но и по id
  extend FriendlyId
    friendly_id :title, :use => :slugged
end
