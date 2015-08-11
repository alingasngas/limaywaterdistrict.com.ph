class HomeController < ApplicationController
  layout 'home'
  
  def index
    @banners = Banner.where('featured = ? AND activate = ?', true, true)
    @page = Page.where(is_root: true).first
    @meta = { title: 'Limay Water District', description: @page.meta_description ? @page.meta_description : '', url: root_url, image:  asset_url('assets/mariwad_office.jpg') }
    #render json: @meta#_description
  end
end
