class AdminController < ApplicationController

  def index
    @products = Product.all
  end

end
