class Workorder < ActiveRecord::Base

  before_save :set_state_default #when a work order is created, its default value should be "Pending"
  #before_create :set_worker
  
  attr_accessible :building, :description, :room, :state, :user_id #should remove state when work logs implemented 
  attr_accessible :building, :description, :room, :state, :user_id, :worker_id, as: :admin #everything accessible as admin
  
  
  belongs_to :user
  belongs_to :worker
  has_many :worklogs, dependent: :destroy
  
 # default_value_for :state, "Pending"
  
  validates :description, presence: true
  validates :building,    presence: true
  validates :user_id,     presence: true
  validates :room,        presence: true
  
  
  def set_state_default
    if (self.worker_id.nil?)
  	   self.state = "Pending"
    elsif (!self.worker_id.nil? && self.state == "Pending")
       self.state = "Assigned"
    end
  end #end function 
  
  def set_worker
  	self.worker_id = nil
  end
	
  #scope :all,         where(  )
  scope :closed,      where(:state => "Closed")
  scope :resolved,    where(:state => "Resolved")
  scope :in_progress, where(:state => "In Progress")
  scope :reopened,    where(:state => "Reopened")
  scope :assigned,    where(:state => "Assigned")
  scope :pending,     where(:state => "Pending")
  scope :deferred,    where(:state => "Deferred")

  default_scope order: 'workorders.updated_at DESC'
end
