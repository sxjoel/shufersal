class AdminController < ApplicationController

  def index
    @products = Product.get_admin_products
  end

end
