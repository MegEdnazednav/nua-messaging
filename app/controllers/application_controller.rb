class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user

  def set_current_user
    @current_user = session['user'] ? User.find(session['user']['id']) : User.current
  end
end
