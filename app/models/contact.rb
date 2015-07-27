class Contact < ActiveRecord::Base
  validates_presence_of :company_name, :street, :country, :phone1, :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_length_of :phone1, :minimum => 7
  validates_length_of :fax, :minimum => 7, :allow_blank => true

  geocoded_by :address
  after_validation :geocode

  has_attached_file :logo, :styles => {
      :thumb => '40x40>'
  },
  :storage => :s3,
  :s3_credentials => S3_CREDENTIALS,
  :url  => '/company-logo/:id/:style/:basename.:extension',
  :path => '/company-logo/:id/:style/:basename.:extension',
  :default_url => '/assets/no-image-available.png',
  :default_style => :thumb
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
  before_post_process :transliterate_file_name

  def transliterate_file_name
    extension = File.extname(logo.original_filename).gsub(/^\.+/, '')
    filename = logo.original_filename.gsub(/\.#{extension}$/, '')
    self.logo.instance_write(:file_name, "#{transliterate(filename)}.#{transliterate(extension)}")
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

  def address
    [street, city, province, country].compact.join(', ')
  end

end
