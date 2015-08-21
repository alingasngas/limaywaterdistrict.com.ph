class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ActionView::Helpers::AssetUrlHelper

  before_action :set_required

  def render_404
    render file: 'public/404'
  end

  def set_required
    @contact = Contact.first
    @latest_posts = Post.active.order('publish_date DESC').limit(7)
    @popular = Page.active.where(is_featured: true, is_root: false, is_contact: false).order('page_title').sample(7)
    if @popular.empty?
      @popular = Page.active.where(is_root: false, is_contact: false).order('page_title').sample(7)
    end
    @featured_articles = Post.active.featured.order('publish_date DESC').limit(3)
    if @featured_articles.empty?
      @featured_articles = Post.active.order('publish_date DESC').limit(3)
    end
  end
  #rescue_from Exception, :with => :server_error

  # def server_error(exception)
  #   ExceptionNotifier.notify_exception(exception,
  #     :env => request.env, :data => {:message => "was doing something wrong"})
  # end
end
