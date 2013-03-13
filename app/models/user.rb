class User < ActiveRecord::Base
  include SimplestAuth::Model

  attr_accessible :email, :password, :password_confirmation, :grad_year, :dorm
  attr_accessor   :password

  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :format => { :with => /\A([a-z]|\d)+@email.wm.edu\z/, :message => "You must have a valid William & Mary student email address to register." }
  validates :password, :confirmation => true
  validates :password_confirmation, :presence => true
  validates :dorm, :presence => true
  validates :grad_year, :presence => true,
                        :inclusion => { :in => (2013..2016).to_a }

  authenticate_by :email
end
