class Worker < ActiveRecord::Base
    include SimplestAuth::Model

    attr_accessible :email, :name, :password, :password_confirmation, :phone
    attr_accessor   :password

    before_save { |user| user.email = email.downcase }

  
    validates :name, :presence => true
    validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :format => { :with => /\A([a-z]|\d)+@(email.|cs.|math.|)wm.edu\z/i, :message => "Invalid email" }
    validates :password, :confirmation => true
    validates :password_confirmation, :presence => true
    validates :phone, :presence => true, :format => { :with => /^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$/, :message => "Invalid phone number" } #got this regex online 

    authenticate_by :email 
end
