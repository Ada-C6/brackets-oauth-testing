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

  def login_status
    if session[:user_id].nil?
      "Not logged in"
    else
      "Logged in as #{user_name}"
    end
  end

  def login_button(**kwargs)
    if session[:user_id].nil?
      text = "Log In"
      path = login_path
      method = :get
    else
      text = "Log Out"
      path = logout_path
      method = :delete
    end
    link_to text, path, method: method, **kwargs
  end

  def render_date(date)
    ("<span class='date'>" + date.strftime("%A, %b %d %Y") + "</span>").html_safe
  end

  def delete_link(item, **kwargs)
    link_to "Delete", item, method: :delete, data: { confirm: "Are you sure you want to delete this?" }, **kwargs
  end
end
