class PagesController < ApplicationController
  layout 'pages'
  before_action :set_default_meta

  def set_default_meta
    meta_title = "Mariveles Water District}"
    @meta = { title: meta_title, description: '', url: Rails.application.routes.default_url_options[:host] }
  end

  def show
    @banners = []
    @page = Page.active.where('page_url = ?', params[:page_url]).first
    unless @page.nil?
    @banners = @page.banners
      if @page.is_full_page?
        render 'pages/full_page', layout: 'blank'
      end
    end
    if @page
    meta_title = "Mariveles Water District - #{@page.meta_title.blank? ? @page.page_title : @page.meta_title}"
    @meta = { title: meta_title, description: @page.meta_description.blank? ?  '' : @page.meta_description, url: "#{Rails.application.routes.default_url_options[:host]}/#{@page.page_url}" }
    end

    render_404 if @page.nil?
    #render json: @meta
  end

  def contacts
    @banners = []
    @page = Page.where(is_contact: true).first
    @contact = Contact.first
    @enquiry = Enquiry.new
    unless @page.nil?
      @banners = @page.banners
      meta_title = "Mariveles Water District - #{@page.meta_title.blank? ? @page.page_title : @page.meta_title}"
      @meta = { title: meta_title, description: @page.meta_description ? @page.meta_description : '', url: "#{Rails.application.routes.default_url_options[:host]}/#{@page.page_url}" }
    end
  end

  def send_enquiry
    @enquiry = Enquiry.new(enquiry_params)
    if @enquiry.valid?
      @enquiry.sent_at = Time.now
      @enquiry.ip_address = request.remote_ip
      @enquiry.save!
      EnquiryMailer.send_enquiry(@enquiry.name, @enquiry.email, @enquiry.message).deliver
      flash[:success] = 'Thank you for reaching out to us. Our support team will make a follow up on your email.'
      redirect_to contact_us_path
    else
      @banners = []
      @page = Page.where(is_contact: true).first
      @contact = Contact.first
      unless @page.nil?
        @banners = @page.banners
        meta_title = "Mariveles Water District - #{@page.meta_title.blank? ? @page.page_title : @page.meta_title}"
        @meta = { title: meta_title, description: @page.meta_description ? @page.meta_description : '', url: "#{Rails.application.routes.default_url_options[:host]}/#{@page.page_url}" }
      end
      render action: 'contacts'
    end

  end

  private

  def enquiry_params
    params.require(:enquiry).permit(:name, :email, :message)
  end
end
