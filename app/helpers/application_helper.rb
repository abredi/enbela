module ApplicationHelper
  def signed_in?
    return true if session[:user_id]

    false
  end

  def authenticated?
    return if signed_in?

    flash[:error] = 'Please login first'
    redirect_to new_session_path
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= session[:user]
  end
end
