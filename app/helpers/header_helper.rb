module HeaderHelper
  def menu_link_to(link_text, link_path, cls: '', mtd: :get)
    class_name = "#{cls} hover:bg-transparent hover:text-orange-1000 px-2 " + (current_page?(link_path) ? 'active' : '')
    link_to link_text, link_path, class: class_name, method: mtd
  end

  def auth_links
    if signed_in?
      concat menu_link_to(current_user.name, user_path(current_user.id), cls: 'text-right')
      menu_link_to 'Log out', session_path(current_user.id), mtd: :delete
    else
      concat menu_link_to 'Login', new_session_path, cls: 'text-right'
      menu_link_to 'Register', new_user_path
    end
  end
end
