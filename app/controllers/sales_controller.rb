class SalesController < ApplicationController
  include Saleable
  skip_before_action :verify_authenticity_token
  deserializable_resource :sale, only: [:create]

  def index
    render jsonapi: Sale.all,
           include: [:client],
           fields: { client: [:name] }
  end

  def show
    sale = Sale.find_by(id: params[:id])
    current_user = Token.get_user( request.headers['Authorization'] )
    if sale.nil? || (current_user != sale.user)
      head :not_found
    else
      compound = []
      if (params.key? :include) && (!params[:include].nil?)
        compound.push :items if (params[:include].split '.').include? 'items'
      end
      render jsonapi: sale,
             include: compound
    end
  end

  def create
    if create_params_validation(params[:sale])
      render json: params[:sale]
    end
  end

  

end