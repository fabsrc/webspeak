class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    return if logged_in?
    store_location
    redirect_to login_url, flash: { danger: 'Please log in.' }
  end

  def admin_user
    return if admin?
    redirect_to :back,
                flash: { danger: 'You have to be an Administrator.' }
  end

  private :logged_in_user, :admin_user
end
