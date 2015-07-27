class Admin::PagesController < ApplicationController

  include Admin::MainModule
  before_filter :set_title
  
  def set_title
    @title = 'Pages Management'
  end
  
  def index
    @pages = Page.all
  end
  
  def show

  end

  def new
    @page = Page.new
    @page.publish_date = Date.today
    #exempt = %w(id last_updated_by created_at updated_at) #array of attributes to be excluded on form
    #attibs = Page.column_types
    #render :json => attibs.select {|k,v| !exempt.include?(k)}
    #a = Page.reflect_on_all_associations#.map{|x| x.class_name}.compact
    #render :text => controller_name.classify

  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def create
    @page = Page.new(page_params)
    @page.last_updated_by = current_user.id
    if @page.publish_date.blank?
      @page.publish_date = Date.today
    end

    if @page.save
      flash[:success] =  "#{ controller_name.singularize.capitalize } successfully added!"
      redirect_to admin_pages_path
    else
      render :action => 'new'
    end
  end
  
  def update
    @page = Page.find(params[:id])
    @page.last_updated_by = current_user.id
    if @page.publish_date.blank?
      @page.publish_date = Date.today
    end
    if @page.update_attributes(page_params)
      flash[:success] =  "#{ controller_name.singularize.capitalize } successfully updated!"
      redirect_to admin_pages_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @page = Page.find(params[:id])
    title = @page.page_title
    if @page.destroy!
      flash[:success] =  "Page #{title} has been deleted!"
      redirect_to admin_pages_path
    end
  end

  private

  def page_params
    params.require(:page).permit!
  end
end
