class UsersController < ApplicationController

  before_action :set_user, only: [ :show , :edit, :update, :destroy]

  def show
    
    set_meta_tags title: @user.name
    @posts = @user.posts.includes(:photos, :likes, :comments)
    @saved = Post.joins(:bookmarks).where("bookmarks.user_id=?", current_user.id).
      includes(:photos, :likes, :comments) if @user == current_user
  end

  def index
    @user = User.new(user_params)
    @users = User.all
    gravatar_id = Digest::MD5::hexdigest(current_user.id).downcase
    "https://www.gravatar.com/avatar/#{gravatar_id}.jpg"
  end


  def new
    if logged_in?
      redirect_to posts_path
    end

    @user = User.new
  end


  def edit
  end


  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html {redirect_to new_session_path ,notice: "Your account has been successfully created"}
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
  params.permit( :name, :email, :password , :password_confirmation)
  end

  def avatar_url user
  return user.image if user.image
  gravatar_id = Digest::MD5::hexdigest(@user.id).downcase
  "https://www.gravatar.com/avatar/#{gravatar_id}.jpg"
   end

end
