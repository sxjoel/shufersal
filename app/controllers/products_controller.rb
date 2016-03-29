class ProductsController < ApplicationController

  def index
    @products = Product.all
    render json: @products
  end

  def create
    prod = Product.first_or_create!(product_params)
    #if user doesnt exist , create it
    user = User.first_or_create!(email: params['email'])
    #if user doesnt exist, create it, else just update amount
    user_product = UserProduct.first_or_create!(user_id: user.id, product_id: prod.id)
    UserProduct.increment_counter(:quantity, user_product.id)
    render json: prod
  end

  def product_params
    params.require(:product).permit!
  end

end
