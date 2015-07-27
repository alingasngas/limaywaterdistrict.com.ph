class Admin::ContactsController < ApplicationController

  include Admin::MainModule
  before_filter :set_title

  def set_title
    @title = 'Contact Us Settings'
  end

  def index
    @contact = Contact.first
    render :show
  end

  def show
    @contact = Contact.first
  end

  def new

  end

  def create

  end

  def edit
    @contact = Contact.first
  end

  def update
    @contact = Contact.first
    @contact.last_updated_by = current_user.id
    if @contact.update_attributes(contact_params)
      flash[:success] =  "#{ controller_name.singularize.capitalize } successfully updated!"
      redirect_to admin_contacts_path
    else
      render :action => 'edit'
    end
  end

  def destroy

  end

  private

  def contact_params
    params.require(:contact).permit!
  end
end
