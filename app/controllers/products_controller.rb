class ProductsController < ApplicationController

  def index
    @products = Product.all
    render json: @products
  end

  def create
    #if user doesnt exist , create it
    user = User.where(email: params['email']).first_or_create!
    params['products'].each do |prd|
      prod = Product.where(shufersal_id: prd['shufersal_id']).first_or_create!
      prod.update_attributes!( name: prd['name'], um: prd['um'], remarks: prd['remarks'], price: prd['price'])
      #if user doesnt exist, create it, else just update amount
      user_product = UserProduct.where(user_id: user.id, product_id: prod.id).first_or_create!
      UserProduct.increment_counter(:quantity, user_product.id)
    end
    render text: 'OK'
  end



end
