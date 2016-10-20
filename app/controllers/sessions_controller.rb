class SessionsController < ApplicationController
  def login
    # Just a booring static page
  end

  def create
    auth_hash = request.env['omniauth.auth']
    redirect to login_failure_path unless auth_hash['uid']

    @user = User.find_by(uid: auth_hash[:uid], provider: 'github')
    if @user.nil?
      # User doesn't match anything in the DB.
      # Attempt to create a new user.
      @user = User.build_from_github(auth_hash)
      render :creation_failure unless @user.save
    end

    # Save the user ID in the session
    session[:user_id] = @user.id

    redirect_to pages_path
  end

  def logout
    session.delete(:user_id)
  end
end
