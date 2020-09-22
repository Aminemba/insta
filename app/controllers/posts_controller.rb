class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :logged_in?

  require 'will_paginate/array'
  
  def index
      @posts = Post.all
      @posts = @posts.paginate(page: params[:page], per_page: 5).order('created_at DESC')
      @post = Post.new
    end

    def show
    end

    def edit
    end

    def new
      if params[:back]
        @post = Post.new(post_params)
      else
        @post = Post.new
      end
    end

    def create
      @post = Post.new(post_params)

      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end




  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    @post = current_user.posts.build(post_params)
    @post.id = params[:id]
 end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
   end
  end


  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content , :id, :image, :image_cache, :user_id)
  end

  # def current_user
  #   @current_user ||= User.find_by(id: session[:user_id])
  # end


end
