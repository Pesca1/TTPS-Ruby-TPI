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

  def show
    if not (p = Product.find_by(code: params[:code])).nil?
      render jsonapi: p
    else
      head :not_found
    end
  end

  def show_items
    if not (p = Product.find_by(code: params[:code])).nil?
      render jsonapi: p
    else
      head :not_found
    end
  end

end