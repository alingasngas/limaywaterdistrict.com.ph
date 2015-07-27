class Admin::PostsController < ApplicationController

  include Admin::MainModule
  before_filter :set_title
  
  def set_title
    @title = 'News and Updates Management'
  end
  
  def index
    @posts = Post.order('publish_date DESC')
  end
  
  def show

  end

  def new
    @post = Post.new
    @post.page_type = 'post'
    @post.publish_date = Date.today
  end
  
  def edit
    @post = Post.find(params[:id])
    @post.page_type = 'post'
  end
  
  def create
    @post = Post.new(page_params)
    @post.last_updated_by = current_user.id
    if @post.publish_date.blank?
      @post.publish_date = Date.today
    end

    if @post.save
      flash[:success] =  "#{ controller_name.singularize.capitalize } successfully added!"
      redirect_to admin_posts_path
    else
      @post.page_type = 'post'
      render :action => 'new'
    end
  end
  
  def update
    @post = Post.find(params[:id])
    @post.last_updated_by = current_user.id
    if @post.publish_date.blank?
      @post.publish_date = Date.today
    end
    if @post.update_attributes(page_params)
      flash[:success] =  "#{ controller_name.singularize.capitalize } successfully updated!"
      redirect_to admin_posts_path
    else
      @post.page_type = 'post'
      render :action => 'edit'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    title = @post.page_title
    if @post.destroy!
      flash[:success] =  "Post has been deleted!"
      redirect_to admin_posts_path
    end
  end

  private

  def page_params
    params.require(:post).permit!
  end
end

