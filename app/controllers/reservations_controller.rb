class ReservationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  deserializable_resource :reservation, only: [:create]
  before_action :create_params_validation, only: [:create]

  def index
    render jsonapi: Reservation.not_sold,
           include: [ :client ],
           fields: { client: [:name] }
  end

  def show
    r = Reservation.find_by(id: params[:id])
    if ! r.nil?
      compound = [ :client ]
      if params.key? :include
        req = params[:include].split '.'
        compound.push :items if req.include? 'items'
        compound.push :sale if req.include? 'sale'
      end
      render jsonapi: r,
             include: compound
    else
      head :not_found
    end
  end

  def create
    reservation = params[:reservation]
    user = Token.get_user(request.headers['Authorization'])
    client = Client.find_by(id: reservation[:client_id])
    r = Reservation.create(user: user, client: client)
    reservation[:products].each do | p |
      Product.find_by(id: p[:id]).reserve(p[:amount], r)
    end
    r.reload
    render jsonapi: r
  end

  def sell
    r = Reservation.find_by(id: params[:id])
    if r.nil?
      head :not_found
    elsif r.is_sold
      render jsonapi: r.sale, status: :ok
    else
      r.sell Token.get_user(request.headers['Authorization'])
      render jsonapi: r.sale, status: :created
    end
  end

  def delete
    r = Reservation.find_by(id: params[:id])
    if r.nil?
      head :not_found
    elsif r.is_sold
      head :conflict
    else
      r.destroy
      head :no_content
    end
  end

  def create_params_validation
    errors = []
    r = params[:reservation]
    if r.key?(:products) && r[:products].any?
      r[:products].each do |p|
        null = false
        if Product.find_by(id: p[:id]).nil?
          errors.push 'invalid_product_id'
          null = true
        end
        if p[:amount] <= 0
          errors.push 'invalid_product_amount'
        elsif !null && p[:amount] > Product.find_by(id: p[:id]).stock
          errors.push 'no_stock'
        end
      end
    else
      errors.push 'no_products'
    end
    if (!r.key? :client_id) || Client.find_by(id: r[:client_id]).nil?
      errors.push 'no_client'
    end
    if errors.any?
      render status: :bad_request, json: { errors: errors.map {|e| { code: e } }}
    end
  end

end