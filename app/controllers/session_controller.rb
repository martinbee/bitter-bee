class SessionController < ApplicationController

  before_action do
    @current_user = User.find_by(id: session[:user_id])
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def new
  end

  def create
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      session[:user_id] = user.id
      @current_user = User.find_by(id: session[:user_id])
      redirect_to [:dashboard, id: session[:user_id]], notice: "Welcome back, #{@current_user.username}"
    else
      redirect_to :root, alert: "Email or Password Incorrect"
    end
  end

  def delete
    session.delete(:user_id)
    @current_user = nil
    redirect_to :root, notice: "You have logged out"
  end

  private

  def password
    password = params[:session][:password]
  end

  def email
    email = params[:session][:email].downcase
  end

end
