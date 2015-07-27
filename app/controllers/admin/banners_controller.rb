class Admin::BannersController < ApplicationController
  include Admin::MainModule
  before_filter :set_title
  before_filter :check_role, :only => [:destroy]

  def check_role
    if is_editor?
      @banners = Banner.all
      flash[:warning] = 'Only admin role is allowed to this action!'
      redirect_to(:action => 'index')
    end
  end

  def set_title
    @title = 'Banners Management'
  end

  def index
    @banners = Banner.all
  end

  def show
    @banner = Topbanner.all
    render :action => "index"
  end

  def new
    @banner = Banner.new
  end

  def edit
    @banner = Banner.find(params[:id])
  end

  def create
    @banner = Banner.new(banner_params)
    @banner.last_updated_by = current_user.id
    if @banner.save
      flash[:success] = 'Banner created successfully!'
      redirect_to(:url => admin_banners_path, :notice => 'Create Banner Successfully!')
    else
      render :action => "new"
    end
  end

  def update
    @banner = Banner.find(params[:id])
    @banner.last_updated_by = current_user.id
    if @banner.update_attributes(banner_params)
      flash[:success] = 'Banner updated successfully!'
      redirect_to admin_banners_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @banner = Banner.find(params[:id])
    @banner.destroy

    redirect_to(admin_banners_path)
  end


  private

  def banner_params
    params.require(:banner).permit!
  end
end
