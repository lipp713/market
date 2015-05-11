class TransactionsController < ApplicationController
  def create
  	product  = Product.find_by!(slug: params[:slug])
  	token = params[:stripeToken] 
  	
    begin 
    
     charge = Stripe::Charge.create(
     	amount: product.price,
     	currency: "gbp",
     	card: token,
     	description: current_user.email)
     
     @sale = product.sales.create!(buyer_email: current_user.email)
     redirect_to pickup_url(guid: @sale.guid)
     
     rescue Stripe::CardError => e
     
      @error = e
      
      redirect_to product_path(product), notice: @error
      
     end
	
  end
 
  def pickup
    @sale = Sale.find_by!(guid: params[:guid])
    @product = @sale.product
  end
end