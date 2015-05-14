class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  def home

  	if current_user
	    redirect_to products_path
	  end

      @products = Product.last(8)
  

  end

  def dashboard
    @products = current_user.products
    @purchased = Sale.where(buyer_email: current_user.email)
    @sales = Sale.where(seller_email: current_user.email)
  end

end
