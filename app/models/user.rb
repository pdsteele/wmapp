class User < ActiveRecord::Base
  include SimplestAuth::Model

  attr_accessible :name, :email, :password, :password_confirmation, :grad_year, :dorm
  attr_accessor   :password

  before_save { |user| user.email = email.downcase }

  #still need name validations
  
  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :format => { :with => /\A([a-z]|\d)+@(email.|cs.|math.|)wm.edu\z/i, :message => "Invalid email" }
  validates :password, :confirmation => true
  validates :password_confirmation, :presence => true
  validates :dorm, :presence => true
  validates :grad_year, :presence => true,
                        :inclusion => { :in => (2013..2016).to_a }

  authenticate_by :email
end
