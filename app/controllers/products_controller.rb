class ProductsController < ApplicationController

  def index
    result = Product.get_products
    render json: result
  end

  def create
    #if user doesnt exist , create it
    user = User.where(email: params['email']).first_or_create!
    products = JSON.parse params['products']
    products.each do |prd|
      prod = Product.where(shufersal_id: prd['shufersal_id']).first_or_create!
      prod.update_attributes!( name: prd['name'], price: prd['price'], img: prd['img'])
      #if userproduct doesnt exist, create it, else just update amount
      user_product = UserProduct.where(user_id: user.id, product_id: prod.id).first_or_create!
      user_product.update_attribute(:quantity, prd['quantity']) if prd['quantity'].present?
      UserProduct.increment_counter(:quantity, user_product.id) if prd['quantity'].blank?

    end
    render text: 'OK'
  end



end
