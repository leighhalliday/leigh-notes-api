class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def current_user
    return nil if auth_header.nil?
    @current_user ||= Auth.lookup_user(auth_header)
  end

  def auth_header
    request.env.fetch("HTTP_AUTHORIZATION", nil)
  end

  def require_authenticated
    return if current_user.present?
    render(status: 401, json: { errors: ["Must be authenticated"] })
  end
end
