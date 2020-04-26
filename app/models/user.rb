class User < ApplicationRecord
  has_many :stocks
  accepts_nested_attributes_for :stocks
  has_many :trades
  accepts_nested_attributes_for :trades

  enum role: {user: 1, manager: 2, admin: 9}
  enum sex: {male: 1, female: 2}
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  PASSWORD_FORMAT = /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/x

  validates :username, :firstname, :lastname, :email, presence: true
  validates :username, :email, :phone, uniqueness: true
  validates :password, :presence => true,
                       :length => {:within => 8..40},
                       :format => {:with => PASSWORD_FORMAT},
                       :on => :create
  validates :password, :presence => true,
                       :length => {:within => 8..40},
                       :format => {:with => PASSWORD_FORMAT},
                       :allow_blank => true,
                       :on => :update
  validate :validate_username
  validate :validate_phone

  attr_writer :login
  def login
    @login || self.username || self.email || self.phone
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value OR lower(phone) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email) || conditions.has_key?(:phone)
      where(conditions.to_h).first
    end
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
    if User.where(phone: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def validate_phone
    if User.where(email: phone).exists?
      errors.add(:phone, :invalid)
    end
    if User.where(username: phone).exists?
      errors.add(:phone, :invalid)
    end
  end

  def fullname
    firstname + " " + lastname
  end
end
