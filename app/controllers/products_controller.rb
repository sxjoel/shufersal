class ProductsController < ApplicationController

  def index
    product_users = UserProduct.pluck(:product_id, :user_id)
    result = {}
    product_users.each do |product_user|
      product = Product.find(product_user[0])
      user = User.find(product_user[1])
      result[product.shufersal_id] = {'user_names'=> []} if !result.has_key?(product.shufersal_id)
      result[product.shufersal_id]['user_names'].push(user.name + " ")
      result[product.shufersal_id]['product'] = product
    end
    render json: result
  end

  def create
    #if user doesnt exist , create it
    user = User.where(email: params['email']).first_or_create!
    products = JSON.parse params['products']
    binding.pry
    products.each do |prd|
      prod = Product.where(shufersal_id: prd['shufersal_id']).first_or_create!
      prod.update_attributes!( name: prd['name'], price: prd['price'], image: prd['img'])
      #if userproduct doesnt exist, create it, else just update amount
      user_product = UserProduct.where(user_id: user.id, product_id: prod.id).first_or_create!
      user_product.update_attribute(:quantity, prd['quantity']) if prd['quantity'].present?
      UserProduct.increment_counter(:quantity, user_product.id) if prd['quantity'].blank?

    end
    render text: 'OK'
  end



end
