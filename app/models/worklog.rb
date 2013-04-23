class Worklog < ActiveRecord::Base
  attr_accessible :description, :fac_man_only, :name, :state, :workorder_id, :unsolicited
  attr_accessible :id, :description, :fac_man_only, :name, :state, :workorder_id, :unsolicited, as: :admin

  before_save :set_defaults

  after_create :set_default_state

  belongs_to :workorder

  validates :description, presence: true
  validates :name, presence: true
  validates_presence_of :workorder

  default_scope order: 'worklogs.updated_at DESC'

  def set_default_state
      self.state = self.workorder.state 
  end
  
  protected 
    def set_defaults #needs to set name automatically, assume default for fac_man boolean if blank, inherit state if blank,  
      
      if(self.name.nil?)
          self.name = current_user.name #name will always be made to be current user's for workers and users - admin will input their name 
      end #endif

      if (self.fac_man_only.nil?)
         self.fac_man_only = false
      end #endif 

      if (self.unsolicited.nil?)
          self.unsolicited = false
      end 

      #decide whether to inherit state here or upon creation
    end #end function

    

  

end
