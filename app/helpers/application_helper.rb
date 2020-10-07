module ApplicationHelper

  def error_notification(f)
    concat f.error_notification
    f.error_notification message: f.object.errors[:base].to_sentence if f.object.errors[:base].present?
  end

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

    @current_user ||= User.new(session[:user])
  end

  def notification_banner
    flash.each do |msg|
      css_class = alert_class(msg[0])
      concat tag.div (tag.p msg[1], class: 'text-sm'), class: 'flex px-8 py-4 bg-' + css_class
    end
  end

  private

  def alert_class(msg)
    case msg
    when 'info'
      'blue-400'
    when 'warning'
      'orange-400'
    else
      'red-500'
    end
  end

  def capitalize_words(string)
    string.gsub(/\S+/, &:capitalize)
  end

  include HeaderHelper
  include ArticlesHelper
end
