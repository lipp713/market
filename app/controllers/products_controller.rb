class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @products = Product.where(availability: true)
    respond_with(@products)
  end

  def show
    respond_with(@product)
  end

  def new
    @product = Product.new
    respond_with(@product)
  end

  def edit
    authorize! :manage, @product
  end

  def create
    @product = current_user.products.new(product_params)
    @product.save
    respond_with(@product)
  end

  def update
    authorize! :manage, @product
    @product.update(product_params)
    respond_with(@product)
  end

  def destroy
    authorize! :manage, @product
    @product.destroy
    respond_with(@product)
  end

  private
    def set_product
      @product = Product.friendly.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :availability, :image)
    end
end
