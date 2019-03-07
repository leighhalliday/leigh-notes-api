class SessionsController < ApplicationController
  before_action :require_authenticated, only: [:destroy]

  def create
    token = Auth.authenticate(params[:email], params[:password])

    if token.present?
      render(json: { token: token })
    else
      render(status: 400, json: { errors: ["Invalid email or password"] })
    end
  end

  def destroy
    Auth.destroy_token(auth_header)
    head(:ok)
  end
end
