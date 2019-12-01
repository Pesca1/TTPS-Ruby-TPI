class ProductsController < ApplicationController


  def index
    filter = params[:q]
    if filter.nil? or filter == 'in_stock'
      products = Product.in_stock
    elsif filter == 'scarce'
      products = Product.scarce
    elsif filter == 'all'
      products = Product.all
    else
      head :bad_request
      return
    end
    render jsonapi: products
  end
end