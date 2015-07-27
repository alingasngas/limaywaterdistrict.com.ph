class Enquiry < ActiveRecord::Base

  include ActionView::Helpers::SanitizeHelper
  validates_presence_of :name, :email, :message
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, allow_blank: true
  before_save :sanitize_attribs

  belongs_to  :user, class_name: 'User', foreign_key: :replied_by

  scope :active, ->{where(is_active: true)}

  def sanitize_attribs
    self.name = name.strip
    self.email = email.strip.downcase
    self.message = strip_tags(message)
  end

  def respondent
    if self.user
      self.user.full_name
    end
    return nil unless self.user
  end


end
