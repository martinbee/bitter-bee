class UserController < ApplicationController

  before_action do
    @current_user = User.find_by(id: session[:user_id])
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      flash.now[:notice] = "Welcome to Bitter!"
      redirect_to [:dashboard, id: session[:user_id]]
    else
      redirect_to :root, notice: "Please correct highlighted fields"
    end
  end

  def edit
    if @current_user.nil?
      redirect_to :root
    else
      @user = User.find(params[:id])
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update user_params
      redirect_to [:user, id: @user.id]
    else
      render :edit, notice: "ERROR"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :photo)
  end

end
