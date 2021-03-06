class ProductsController < ApplicationController
  skip_before_action  :verify_authenticity_token
  deserializable_resource :item, only: [:add_items]
  before_action :verify_product_code, only: [:show, :show_items, :add_items]

  def index
    filter = params[:q]
    page_number = params[:page].to_i
    page_number = 1 if page_number < 1
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
    page = products.paginate(page: page_number)
    render jsonapi: page,
           links: { page: page_number, 
                    next: (url_for(page: page.next_page)     if !page.next_page.nil?), 
                    prev: (url_for(page: page.previous_page) if !page.previous_page.nil?),
                    first: url_for(page: 1),
                    last:  url_for(page: page.total_pages) }
  end

  def verify_product_code
    if Product.find_by(code: params[:code]).nil?
      head :not_found
    end
  end

  def show
    render jsonapi: Product.find_by(code: params[:code])
  end

  def show_items
    p = Product.find_by(code: params[:code])
    render jsonapi: p.items,
           include: :product
  end

  def add_items
    if (params.key? :item) && (params[:item].key? :amount) && (params[:item][:amount] > 0)
      p = Product.find_by(code: params[:code])
      render jsonapi: p.add_items(params[:item][:amount]),
             include: :product
    else
      head :bad_request
    end
  end

end