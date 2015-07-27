class Post < Page
  include ActionView::Helpers
  include ApplicationHelper
  has_attached_file :photo, :styles => {
      :large => "1280x400>",
      :medium => "960x300>",
      :thumb => "120x50>"
  },
  :storage => :s3,
  :s3_host_name => 's3-ap-southeast-1.amazonaws.com',
  :s3_credentials => S3_CREDENTIALS,
  :url  => "/post-cover/:id/:style/:basename.:extension",
  :path => "/post-cover/:id/:style/:basename.:extension",
  :default_url => "/assets/front/no-image.png",
  :default_style => :medium
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  before_validation   :add_default_page_url
  belongs_to  :user, :class_name => 'User', :foreign_key => :last_updated_by
  before_validation   :add_default_page_url
  before_save :build_meta, :assign_default
  validates :page_title, :presence => true
  validates_length_of :page_url, :within => 3..255, :allow_blank => true
  validates_uniqueness_of :page_title, :page_url
  scope :active, -> {where(activate: true)}
  scope :featured, -> {where(is_featured: true)}
  before_post_process :transliterate_file_name

  def transliterate_file_name
    extension = File.extname(photo.original_filename).gsub(/^\.+/, '')
    filename = photo.original_filename.gsub(/\.#{extension}$/, '')
    self.photo.instance_write(:file_name, "#{transliterate(filename)}.#{transliterate(extension)}")
  end

  def self.default_scope
    where("page_type = ?", 'post')
  end

  def add_default_page_url
    unless self.page_title.blank?
      self.page_url = self.page_title.parameterize
    end
  end

  def assign_default
    self.page_type = 'post'
  end

  def get_meta_info
    meta_info = {
        title: "Mariveles Water District | #{self.page_title}",
        description: short_description(self.body, 200),
        url: Rails.application.routes.url_helpers.show_post_url(self.page_url)
    }
    if self.photo.present?
      meta_info[:image] = self.photo.url(:thumb)
    end
    meta_info
  end

  def transliterate(str)
    s = Iconv.iconv('ascii//ignore//translit', 'utf-8', str).to_s
    s.downcase!
    s.gsub!(/'/, '')
    s.gsub!(/[^A-Za-z0-9]+/, ' ')
    s.strip!
    s.gsub!(/\ +/, '-')
    return s
  end
end