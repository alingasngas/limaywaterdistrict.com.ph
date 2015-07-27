class User < ActiveRecord::Base

  require 'iconv'
  require 'bcrypt'
  attr_accessor :password, :password_confirmation
  belongs_to :role
  has_many :pages, :class_name => 'Page', :foreign_key => :last_updated_by
  has_many :banners, :class_name => 'Banner', :foreign_key => :last_updated_by

  #Validate Presence
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :username
  validates_presence_of :password, :on => :create
  #validates_presence_of :password_confirmation, :on => :change_password
  validates_presence_of :email
  validates_presence_of :role_id
  #Validate Length
  validates_length_of :username, :within => 3..20,	:allow_blank => false
  validates_length_of :email, :within => 3..50,	:allow_blank => false
  validates_length_of :password, :within => 3..20, :on => :create
  validates_length_of :password_confirmation, :within => 3..20, :on => :update, :if => :password_required?
  #Validate Uniqueness
  validates_uniqueness_of :username, :message => "was in use. Please use another username"
  validates_uniqueness_of :email, :on => :create, :message => "was in use. Please use another email"
  #Confirmation
  validates_confirmation_of :password, :on => :create
  validates_confirmation_of :password, :on => :update, :if => :password_required?
  #Validate Format
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates_format_of :username, :with => /\A(^[a-zA-Z0-9_]{3,20}$)\Z/


  before_save :prepare_password
  #Method
  def self.authenticate(login, pass)
     user = find_by_username(login) || find_by_email(login)
     return nil if user.nil?
     return user if user && user.password_hash == user.encrypt_password(pass)
     nil
  end

  def username=(username)
    write_attribute(:username, username.downcase)
  end

  def full_name
    full_name = ''
    unless self.first_name.nil?
      full_name = full_name + ' ' + self.first_name.capitalize
    end
    unless self.last_name.nil?
      full_name = full_name + ' ' + self.last_name.capitalize
    end

    return full_name
  end

  def is_admin?
    self.role.name == 'Admin'
  end

  def is_editor?
    self.role.name == 'Editor'
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end


	private

	def password_required?
		!password.blank?
	end

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end



end