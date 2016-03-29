class User < ActiveRecord::Base
  has_many :products, through: :user_products
  validates :email, presence: true
end
