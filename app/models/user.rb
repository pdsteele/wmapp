class User < ActiveRecord::Base
  include SimplestAuth::Model

  attr_accessible :name, :email, :password, :password_confirmation, :dorm, :phone, :room, :bannerID
  attr_accessor   :password
  attr_accessible :email, :name, :password, :password_confirmation, :dorm, :phone, :room, :bannerID, :crypted_password, as: :admin

  has_many :workorders, dependent: :destroy

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token


  validates :name, :presence => true
  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :format => { :with => /\A([a-z]|\d)+@(email.|cs.|math.|)wm.edu\z/i, :message => "is not a valid wm email" }
  validates :password, :confirmation => true
  validates :password_confirmation, :presence => true
  validates :dorm, :presence => true
  validates :phone, :presence => true, :format => { :with => /^(1-|1)?\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/, :message => "is invalid" } #got this regex online
  validates :room, :presence => true
  validates :bannerID, :presence => true, :format => { :with => /^930[0-9]{6}$/, :message => "is not a valid banner ID number" }

  authenticate_by :email

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
