class Worker < ActiveRecord::Base
    include SimplestAuth::Model

    attr_accessible :email, :name, :phone, :password, :password_confirmation, :total_workorders_completed, :average_workorder_rating
    attr_accessible :email, :name, :phone, :password, :password_confirmation, :crypted_password, as: :admin

    before_save { |user| user.email = email.downcase }
    before_save :create_remember_token

    before_create :set_stats_to_zero  #only do this when a new worker is created

    has_many :workorders, dependent: :destroy
    has_many :worklogs #do not use destroy dependency here, so comments may still exist 

  
    validates :name,  :presence => true
    validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :format => { :with => /\A([a-z]|\d)+@(email.|cs.|math.|)wm.edu\z/i, :message => "Invalid email" }
	  validates :phone, :presence => true, :format => { :with => /^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$/, :message => "Invalid phone number" } #got this regex online
    
    validates :password, :confirmation => true
    #validates :password_confirmation, :presence => true , :on => :create

    validates :password_confirmation, :presence => true

    authenticate_by :email 

    def set_total_workorders(new_total)
      #self.total_workorders_completed = new_total

      #self.save!
      puts "The functional return value in set_total_workorders"
      puts self.update_attributes( :total_workorders_completed => new_total )
    end

    def set_average_workorder_rating(new_average)
      #self.average_workorder_rating = new_average
      #self.save!

      puts "The functional return value in average workorder_rating"
      puts self.update_attributes( :average_workorder_rating => new_average )

    end


    private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    # we want these to be defined before a worker
    # is created otherwise we'll get nil
    def set_stats_to_zero
      self.average_workorder_rating   = 0.0
      self.total_workorders_completed = 0
    end

end
