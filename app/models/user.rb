class User < ActiveRecord::Base
  has_many :products, through: :user_products
  validates :email, presence: true
  before_save :fetch_name_from_email

  def fetch_name_from_email
    self.name = self.email.split('@')[0]
  end

end
