class PagesController < ApplicationController

  before_action do
    @current_user = User.find_by(id: session[:user_id])
  end

  def index
    @posts = Post.all
    @user = User.new
  end

  def dashboard
    if @current_user.nil?
      redirect_to :root
    else
      @post = Post.new
     followers_ids = @current_user.following_users.pluck(:id)
     posts_ids = followers_ids << @current_user.id
     @posts = Post.where(user_id: posts_ids).order("created_at desc")
     @users = User.all.reject{|user| @current_user.following? user}.reject{|user| @current_user == user}
     @following_count = @current_user.following_users.count
     @random_users = @users.sample(5)
   end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.user_id = @current_user.id
    if @post.save
      redirect_to :dashboard
    else
      render :dashboard, notice: "There appears to be an error"
    end
  end

  def edit
  end

  def delete
  end

  def profile
    if @current_user.nil?
      redirect_to :root
    else
      @user = User.find(params[:id])
    end
  end


  def follow
    user = User.find params[:id]
    @current_user.follow user
    redirect_to :dashboard, notice: "You're now commiserating with #{user.username}"
  end

  def unfollow
    user = User.find params[:id]
    @current_user.stop_following user
    redirect_to :dashboard, notice: "$%@! #{user.username}"
  end

  private

  def post_params
    params.require(:post).permit(:content, :tag_list, :photo)
  end

end
