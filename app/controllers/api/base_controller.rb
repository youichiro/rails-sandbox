class Api::BaseController < ApplicationController
  before_action :login_required

  def login_required
    if !current_user
      render json: { message: 'unauthorized' }, status: 401
    end
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
