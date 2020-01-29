class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  deserializable_resource :user, only: [:create, :auth]

  def create
    new_user = User.new(create_params)
    if new_user.save
      render jsonapi: new_user, status: :no_content
    else
      res = {errors:[]}
      if new_user.errors[:name].any?
        res[:errors].push( { code: "invalid_name" } )
      end
      if new_user.errors.details[:password].includes? error: :blank
        res[:errors].push( { code: "blank_password" } )
      end
      render json: res, status: :conflict
    end
  end

  def create_params
    params.require(:user).permit(:name, :password)
  end

  def auth
    res = {errors:[]}
    user = params.require(:user)
    if not user.key? :u or not user.key? :p
      res[:errors].push( { code: "invalid_request" } )
      render json: res, status: :bad_request
    elsif (u = User.find_by(name: user[:u])).nil?
      res[:errors].push( { code: "user_not_found" } )
      render json: res, status: :forbidden
    elsif u.password != user[:p]
      res[:errors].push( { code: "incorrect_password" } )
      render json: res, status: :forbidden
    else
      t = Token.generate(u)
      render jsonapi: t,
             include: [:user],
             fields: { users: [:name]}
    end
  end
end