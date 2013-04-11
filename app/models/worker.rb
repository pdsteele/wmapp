class Worker < ActiveRecord::Base
    include SimplestAuth::Model

    attr_accessible :email, :name, :phone, :password, :password_confirmation
    attr_accessible :email, :name, :phone, :password, :password_confirmation, :crypted_password, as: :admin

    before_save { |user| user.email = email.downcase }
    before_save :create_remember_token

    has_many :workorders, dependent: :destroy

  
    validates :name,  :presence => true
    validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :format => { :with => /\A([a-z]|\d)+@(email.|cs.|math.|)wm.edu\z/i, :message => "Invalid email" }
	validates :phone, :presence => true, :format => { :with => /^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$/, :message => "Invalid phone number" } #got this regex online 
    
    validates :password, :confirmation => true
    validates :password_confirmation, :presence => true

    authenticate_by :email 

	##
	# each worker can have multiple workorders and, hence, multiple workorder relationships.
	# we state thtat the foreign_key is the workorder_id since this should uniquely identify each 
	# relationship.  When a worker is deleted his workorders should be too.
	#has_many :workorder_relationships, foreign_key: "worker_id", dependent: :destroy
	
	#has_many :work_assignments, through: :workorder_relationships #, source: :



	##
	# Assignment is only done by an administrator
	#
	#def isAssigned?(workorder)
	# 	workorder_relationships.find_by_workorder_id(workorder.id)
	# end
	
	# def assign!( workorder )
	# 	puts("hello")
	# 	puts(" The workorder id: #{workorder.id}", workorder.id )
		
	# 	##
	# 	# create! is a rails-defined method created by the has_many association.
	# 	# Note that rails will automatically define the worker_id column since
	# 	# we've used that as the primary key.  However, we have to pass it the 
	# 	# workorder_id
	# 	workorder_relationships.create!(workorder_id: workorder.id) 
	# end 
	
	# def unassign!( workorder )
	# 	workorder_relationships.find_by_workorder_id(workorder.id).destroy
	# end


    private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
