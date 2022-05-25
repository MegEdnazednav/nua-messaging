class SessionsController < ApplicationController
  def set_user
    session[:user] = User.find(user_params[:user_id])
    redirect_to messages_path
  end

  private
  def user_params
    params.require(:user).permit(:user_id)
  end
end
