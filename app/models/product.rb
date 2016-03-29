class Product < ActiveRecord::Base
  validates :shufersal_id, presence: true, uniqueness: true
  has_many :users, through: :user_products


  def self.get_admin_products
    product_users = UserProduct.pluck(:product_id, :user_id)
    result = {}
    product_users.each do |product_user|
      product = Product.find(product_user[0])
      user = User.find(product_user[1])
      result[product.shufersal_id] = {'user_names'=> []} if !result.has_key?(product.shufersal_id)
      result[product.shufersal_id]['user_names'].push(user.name + " ")
      result[product.shufersal_id]['product_name'] = product.name
      result[product.shufersal_id]['quantity'] =  result[product.shufersal_id]['quantity'].to_i + UserProduct.where(user_id: user.id, product_id: product.id).first.quantity.to_i
      result[product.shufersal_id]['price'] = product.price
      # result[product.shufersal_id]['product']['quantity'] +=
    end
    result.values
  end

  def self.get_products
    product_users = UserProduct.pluck(:product_id, :user_id)
    result = {}
    product_users.each do |product_user|
      product = Product.find(product_user[0])
      user = User.find(product_user[1])
      result[product.shufersal_id] = {'user_names'=> []} if !result.has_key?(product.shufersal_id)
      result[product.shufersal_id]['user_names'].push(user.name + " ")
      result[product.shufersal_id].merge!(shufersal_id: product.shufersal_id)
      # result[product.shufersal_id]['product']['quantity'] +=
    end
    result.values
  end

end
