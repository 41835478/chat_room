class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  before_action :authenticate_user!, :set_user_cookies
  helper_method :set_user_cookies

  before_action do
    if devise_controller?
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation) }
      devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    end
  end

  private
  def set_user_cookies
    cookies.signed[:user_id] = current_user.id if current_user
  end
end
