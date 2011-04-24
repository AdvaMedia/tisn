require 'digest/sha1'
class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  validates_presence_of     :password, :message=>"Пароль не может быть пустым"
  validates_length_of       :password,    :within => 6..100, :message=>"Должен быть длиннее 6 символов"
  
  validates_presence_of     :password_confirmation, :message=>"Подтверждение пароля не может быть пустым"
  validates_length_of       :password_confirmation,    :within => 6..100, :message=>"Должен быть длиннее 6 символов"

  has_and_belongs_to_many :roles

  def has_role(rolename)
    role=Role.find_by_name(rolename)
    role.blank? ? false : roles.include?(role)
  end

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :email, :password, :password_confirmation

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def admin?
    admrole=Role.find_by_name("Admins")
    if admrole==nil
      return false
    end

    return roles.include?(admrole)
  end

  

end
