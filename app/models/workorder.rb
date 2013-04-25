class Workorder < ActiveRecord::Base

  before_save :set_state_default #when a work order is created, its default value should be "Pending"

  
  attr_accessible :building, :description, :room, :state, :user_id, :worker_id  
  attr_accessible :building, :description, :room, :state, :user_id, :worker_id, as: :admin #everything accessible as admin
  
  
  belongs_to :user
  belongs_to :worker
  has_many :worklogs, dependent: :destroy
  
  
  validates :description, presence: true
  validates :building,    presence: true
  validates :user_id,     presence: true
  validates :room,        presence: true
  
  #scope :all,         where(  )
  scope :closed,      where(:state => "Closed")
  scope :resolved,    where(:state => "Resolved")
  scope :in_progress, where(:state => "In Progress")
  scope :reopened,    where(:state => "Reopened")
  scope :assigned,    where(:state => "Assigned")
  scope :pending,     where(:state => "Pending")
  scope :deferred,    where(:state => "Deferred")

  default_scope order: 'workorders.updated_at DESC'

  protected 
    def set_state_default

      # #gets set to pending if no worker exists, unless user cancels or reopens
      #COMMENTED OUT BECAUSE IT BREAKS CERTAIN CASES -> strange and not worth the time 
      # if (self.worker_id.nil? && (self.state == "In Progress" || self.state == "Assigned" || self.state == "Deferred"))
    	 #   self.state = "Pending"
      # #changing a workorder to pending will reset the worker
      # elsif (!self.worker_id.nil? && self.state == "Pending") 
      #    self.worker_id = nil
      #    self.worker = nil
      # end

      #state SHOULD NEVER BE NIL - adopt it from a worklog or set it to pending 
      if (self.state.nil?)
        if (!self.worklogs.first.nil?)
          self.state = self.worklogs.first.state
        else
          self.state = "Pending"
        end #end inner if
      end #end outer if 

    end #end function 
	

end
