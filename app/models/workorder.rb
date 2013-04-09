class Workorder < ActiveRecord::Base

  before_create :set_state_default #when a work order is created, its default value should be "Pending"
  before_create :set_worker_to_None
  
  attr_accessible :building, :description, :room,  :user_id
  attr_accessible :building, :description, :room, :state, :worker, :user_id, as: :admin #everything accessible as admin
  
  belongs_to :user
  
 # default_value_for :state, "Pending"
  
  validates :description, presence: true
  validates :building,    presence: true
  validates :user_id,     presence: true
  validates :room,        presence: true
  
  
  def set_state_default
  	self.state = "Pending"
  end
  
  def set_worker_to_None
  	self.worker = "None"
  end
	
  #scope :all,         where(  )
  scope :completed,   where(:state => "Completed")
  scope :in_progress, where(:state => "In Progress")
  scope :pending,     where(:state => "Pending")

  default_scope order: 'workorders.created_at DESC'
end
