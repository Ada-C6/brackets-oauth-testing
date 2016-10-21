module ApplicationHelper
  def user_name
    begin
      user = User.find(session[:user_id])
      if user.name
        return user.name
      elsif user.email
        return user.email
      else
        return "#{user.provider} user #{user.uid}"
      end
    rescue ActiveRecord::RecordNotFound
      return "ERROR: user not in database"
    end
  end

  def login_button
    if session[:user_id].nil?
      text = "Log In"
      path = login_path
      method = :get
    else
      text = "Log Out"
      path = logout_path
      method = :delete
    end
    link_to text, path, method: method
  end
end
