class Api::UsersController < Api::BaseController
  skip_before_action :login_required, only: [ :create ]

  def show
    render json: @current_user
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      render json: user
    else
      render json: user.errors, status: 422
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
