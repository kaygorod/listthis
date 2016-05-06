class User < ActiveRecord::Base
  has_many :lists
  has_many :items
  has_many :votes
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def to_param
    username
  end
end
