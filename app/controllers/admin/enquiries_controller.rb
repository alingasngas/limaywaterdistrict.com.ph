class Admin::EnquiriesController < ApplicationController
  include Admin::MainModule
  before_filter :set_title

  def set_title
    @title = 'Enquiries Management'
  end

  def index
    @enquiries = Enquiry.active.order('created_at DESC')
    #render json: @enquiries
  end

  def show
    @enquiry = Enquiry.find(params[:id])
  end

  def destroy
    @enquiry = Enquiry.find(params[:id])
    if @enquiry
      @enquiry.update_attributes(is_active: false)
    end
    redirect_to admin_enquiries_path
  end
end
