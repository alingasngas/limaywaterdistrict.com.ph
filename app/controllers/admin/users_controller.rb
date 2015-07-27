class Admin::UsersController < ApplicationController
  include Admin::MainModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :edit, :create, :update, :destroy]

  def check_role
    if is_editor?
      @users = User.all
      flash[:warning] = 'Only admin role is allowed to this action!'
      redirect_to(:action => "index")
    end
  end

  def set_title
    @title = "Users Management"
  end

  def index
    @users = User.all

  end

  def show

    @user = User.find(params[:id])
    render :action => "index"
  end

  def new
    @user = User.new
  end

  def edit
    @title = "Edit User"
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] =  "#{ controller_name.singularize.capitalize } successfully added!"
      redirect_to admin_users_path
    else
      render :action => "new"
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] =  "#{ controller_name.singularize.capitalize } successfully updated!"
      redirect_to admin_users_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    flash[:success] =  "User #{username} has been deleted!"
    @user.destroy

    redirect_to(admin_users_url)
  end
  private
  def user_params
    params.require(:user).permit!
  end

end
