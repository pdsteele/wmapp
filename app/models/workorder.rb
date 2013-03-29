class Workorder < ActiveRecord::Base
  attr_accessible :building, :description, :room, :state, :worker
end
