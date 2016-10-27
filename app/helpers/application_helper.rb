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

  def delete_link(item, klass="")
    klass += " alert button"
    link_to "Delete", item, method: :delete, data: { confirm: "Are you sure you want to delete this?" }, class: klass
  end

  def upvote_link(item, klass="")
    # Note: while this button sends the right type
    # of request, we currently don't have any
    # ranking implemented on the server.
    klass += " warning button"
    capture do
      form_for item, method: :patch, html: { class: "button-form" } do |f|
        concat f.hidden_field :upvote, value: true
        concat f.submit "Upvote", class: klass
      end
    end
  end

  def nicole_button
    # html_safe is idempotent! woah!
    link = link_to "Whatever", "#"
    "<div class=\"foo bar\">#{link}</div>".html_safe
  end
















end
