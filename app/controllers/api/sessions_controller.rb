class Api::SessionsController < Api::BaseController
  skip_before_action :login_required, only: [ :create ]

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { message: 'ok' }, status: 200
    else
      render json: { message: 'unauthorized' }, status: 401
    end
  end

  def destroy
    reset_session
    @current_user = nil
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
