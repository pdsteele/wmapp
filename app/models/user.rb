class User < ActiveRecord::Base
  include SimplestAuth::Model

  attr_accessible :name, :email, :password, :password_confirmation, :dorm, :phone, :room, :bannerID
  attr_accessor   :password

  has_many :workorders, dependent: :destroy

  before_save { |user| user.email = email.downcase }

  
  validates :name, :presence => true
  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :format => { :with => /\A([a-z]|\d)+@(email.|cs.|math.|)wm.edu\z/i, :message => "is not a valid wm email" }
  validates :password, :confirmation => true
  validates :password_confirmation, :presence => true
  validates :dorm, :presence => true
  validates :phone, :presence => true, :format => { :with => /^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$/, :message => "is invalid" } #got this regex online 
  validates :room, :presence => true
  validates :bannerID, :presence => true, :format => { :with => /^930[0-9][0-9][0-9][0-9][0-9][0-9]$/, :message => "is not a valid banner ID number" }

  authenticate_by :email 
end
