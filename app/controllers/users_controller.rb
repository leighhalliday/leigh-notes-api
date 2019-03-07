class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      token = Auth.authenticate_user(user)
      render(json: { token: token })
    else
      render(status: 400, json: { errors: user.errors.full_messages })
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
