##
# Model to create a work order relationship (essentially an assignment). 
# Idea is that an assignment is created when it is assigned and destroyed
# when it is cleared
##
class WorkorderRelationship < ActiveRecord::Base


  attr_accessible  :workorder_id, :worker_id, as: :admin
  
  
  #a workorder relationship belongs to both a worker and a workorder
  belongs_to :workorder, class_name: "Workorder"
  belongs_to :worker,    class_name: "Worker"
  

  
  validates :worker_id,    presence: true
  validates :workorder_id, presence: true
  
  
  puts( "Makes it in workorder relationship" )

end
