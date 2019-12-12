class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_uri
  def current_uri
    @current_uri = request.env['PATH_INFO']
  end
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end
end
