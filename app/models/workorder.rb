class Workorder < ActiveRecord::Base
  attr_accessible :building, :description, :room, :state, :worker, :user_id
  attr_accessible :building, :description, :room, :state, :worker, :user_id, as: :admin
  belongs_to :user

  default_scope order: 'workorders.created_at DESC'
end
