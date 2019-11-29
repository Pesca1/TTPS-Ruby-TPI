class ApplicationController < ActionController::Base
  before_action :require_content_type
  after_action :add_content_type

  def require_content_type
    if request.content_type != "application/vnd.api+json"
      head :unsupported_media_type
    end
  end

  def add_content_type
    response.set_header("Content-Type", "application/vnd.api+json")
  end
end
