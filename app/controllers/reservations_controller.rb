class ReservationsController < ApplicationController
  include Saleable
  skip_before_action :verify_authenticity_token
  deserializable_resource :reservation, only: [:create]

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
    if create_params_validation(params[:reservation])
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

end