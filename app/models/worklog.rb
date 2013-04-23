class Worklog < ActiveRecord::Base
  attr_accessible :description, :fac_man_only, :name, :state, :workorder_id, :workorder,  :unsolicited, :worker_id
  attr_accessible :id, :description, :fac_man_only, :name, :state, :workorder_id, :workorder, :worker_id, :worker, :unsolicited, as: :admin

  before_save :set_defaults

  before_validation :check_for_state_change

  after_create :set_default_state

  belongs_to :workorder
  belongs_to :worker 

  validates :description, presence: true
  validates :name, presence: true
  validates_presence_of :workorder

  default_scope order: 'worklogs.created_at DESC'

  def set_default_state
      self.state = self.workorder.state 
  end
  
  protected 
    def set_defaults #needs to set name automatically, assume default for fac_man boolean if blank, inherit state if blank,  
      
      if(self.name.nil?)
          self.name = current_user.name #name will always be made to be current user's for workers and users - admin will input their name automatically 
      end #endif

      if (self.fac_man_only.nil?)
         self.fac_man_only = false
      end #endif 

      if (self.unsolicited.nil?)
          self.unsolicited = false
      end 

      #inherits state if blank
      if (self.state.nil?)
        self.state = self.workorder.state
      
      elsif (self.state != self.workorder.state) 
        # WORKORDER INHERITS STATE AND WORKER FROM WORKLOG
        self.workorder.state = self.state

        if (!self.worker_id.nil?) #only inherits non-nil workers during a state change 
          self.workorder.worker_id = self.worker_id
          self.workorder.worker = self.worker
        end #end inner if 

        self.workorder.save
      end #end outer if 

      #sets new worker in workorder if it has changed, but state has now 
      if ((!self.worker_id.nil?) and (self.worker_id != self.workorder.worker_id))
        self.workorder.worker_id = self.worker_id
        self.workorder.worker = self.worker
        self.workorder.save
      end

      if (self.description.nil?)
        self.description = "Changed state to " + self.state
      end #end if

    end #end function

    def check_for_state_change

      if (self.description.nil?)
        self.description = "Changed state to " + self.state
      end #end if
    end # end fn

    

  

end
