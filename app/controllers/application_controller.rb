class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  include SessionsHelper
  include PostsHelper

  helper_method :logged_in?, :current_user

  def authenticate_user
    if @current_user == nil
      flash[ :notice ]= t('notice.login_needed')
      redirect_to new_session_path
    end
  end

  # def avatar_url user
  # return user.image if user.image
  # gravatar_id = Digest::MD5::hexdigest(current_user.id).downcase
  # "https://www.gravatar.com/avatar/#{gravatar_id}.jpg"
  # end


end
