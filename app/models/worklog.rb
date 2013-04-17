class Worklog < ActiveRecord::Base
  attr_accessible :description, :fac_man_only, :name, :state, :workorder_id

  before_save :set_defaults

  belongs_to :workorder

  validates :description, presence: true
  validates :name, presence: true
  
  def set_defaults #needs to set name automatically, assume default for fac_man boolean if blank, inherit state if blank,  
    
    if(self.name.nil?)
        self.name = current_user.name #name will always be made to be current user's for workers and users - admin will input their name 
    end #endif

    if (self.fac_man_only.nil?)
       self.fac_man_only = false
    end #endif 

    #decide whether to inherit state here or upon creation
  end #end function

end
