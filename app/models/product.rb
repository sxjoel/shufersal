class Product < ActiveRecord::Base
  validates :shufersal_id, presence: true, uniqueness: true
  has_many :users, through: :user_products

end
