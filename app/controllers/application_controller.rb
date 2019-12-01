class ApplicationController < ActionController::Base
  before_action :require_content_type
  before_action :verify_auth
  after_action :add_content_type

  def require_content_type
    if request.content_type != "application/vnd.api+json"
      head :unsupported_media_type
    end
  end

  def verify_auth
    resource = request.fullpath.split("?")[0]
    token = request.headers['Authorization']
    auth_url = url_for(action: 'auth', controller: 'users', only_path: true)
    singup_url = url_for(action: 'create', controller: 'users', only_path: true)
    if resource != auth_url and resource != singup_url
      if token.nil? or not Token.is_valid(token)
        head :forbidden
      end
    end
  end

  def add_content_type
    response.set_header("Content-Type", "application/vnd.api+json")
  end
end
