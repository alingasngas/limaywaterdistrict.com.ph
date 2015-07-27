class Banner < ActiveRecord::Base
  require 'iconv'
  belongs_to :user, :class_name => 'User', :foreign_key => :last_updated_by
  has_many :page_banners, :dependent => :destroy
  has_many :pages, :through => :page_banners
  has_attached_file :banner, :styles => {
      :large => "1280x400>",
      :medium => "960x300>",
      :thumb => "120x50>"
  },
  # :url  => '/images/banners/:id/:style/:basename.:extension',
  # :path => ':rails_root/public/images/banners/:id/:style/:basename.:extension',
  # :default_url => '/assets/frontend/no-image.jpg',
  :storage => :s3,
  :s3_credentials => S3_CREDENTIALS,
  :s3_host_name => 's3-ap-southeast-1.amazonaws.com',
  :url  => "/banners/:id/:style/:basename.:extension",
  :path => "/banners/:id/:style/:basename.:extension",
  :default_url => "/assets/front/no-image.png",
  :default_style => :medium
  validates_attachment_content_type :banner, :content_type => /\Aimage\/.*\Z/
  validates_attachment_presence :banner
  before_post_process :transliterate_file_name

  def transliterate_file_name
    extension = File.extname(banner.original_filename).gsub(/^\.+/, '')
    filename = banner.original_filename.gsub(/\.#{extension}$/, '')
    self.banner.instance_write(:file_name, "#{transliterate(filename)}.#{transliterate(extension)}")
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
