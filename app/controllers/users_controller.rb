class UsersController < ApplicationController

  before_action :set_user, only: [ :show , :edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    @post = @user.posts.build
    @comments = Comment.all
  end

  def index
    @users = User.all
    @friendships = current_user.friendships
    @inverse_friendships = current_user.inverse_friendships
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
    params.require(:user).permit( :name, :email, :password , :password_confirmation)
  end
end
