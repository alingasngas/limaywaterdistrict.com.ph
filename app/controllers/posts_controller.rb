class PostsController < ApplicationController
  layout 'pages'

  before_action :set_defaults, :build_archives

  def build_archives
    @archives = Post.active.order('publish_date DESC').group_by {|p| p.publish_date.beginning_of_month rescue p.created_at.beginning_of_month }
    #@archives.keys.map {|a| a.strftime('%B %Y')}
  end

  def set_defaults
    @banners = []
    @meta = {
        title: 'Mariveles Water District | News and Updates',
        description: 'Mariveles Water District | News and Updates',
        url: posts_url,
        image:  asset_url('assets/mariwad_office.jpg')
    }
  end

  def index
    params[:page] ||= 1
    if params[:d] && params[:d].present?
      @posts = Post.where(activate: true).where('publish_date BETWEEN ? AND ?', params[:d].to_date.beginning_of_month, params[:d].to_date.end_of_month).order('publish_date DESC').page(params[:page]).per(5)
    elsif params[:q] && params[:q].present?
      keyword = params[:q].strip.downcase
      @posts = Post.where(activate: true).where('LOWER(page_title) LIKE ? OR LOWER(page_subtitle) LIKE ? OR LOWER(body) LIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%").order('publish_date DESC').page(params[:page]).per(5)
    else
      @posts = Post.where(activate: true).order('publish_date DESC').page(params[:page]).per(5)
    end


  end

  def show
    @post = Post.where(page_url: params[:page_url]).first
    if @post
      @meta = @post.get_meta_info
    else
      redirect_to posts_path
    end
  end
end
