class TransactionsController < ApplicationController
	def create
		product = Product.find_by!(slug: params[:slug])
		sale = product.sales.create(
			amount: product.price,
			buyer_email: current_user.email,
			seller_email: product.user.email,
			stripe_token: params[:stripeToken])
		sale.process!
		if sale.finished?
			redirect_to pickup_url(guid: sale.guid), notice: "Transaction Successful"
		else
			redirect_to product_path(product), notice: "Something went wrong"
		end
	end

	def pickup
		@sale = Sale.find_by!(guid: params[:guid])
		@product = @sale.product
	end
end