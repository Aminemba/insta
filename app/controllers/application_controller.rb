class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  include SessionsHelper
  include PostsHelper
  require 'will_paginate/array'

  helper_method :logged_in?, :current_user

  def authenticate_user
    if @current_user == nil
      flash[ :notice ]= t('notice.login_needed')
      redirect_to new_session_path
    end
  end

end
