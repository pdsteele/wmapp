class Buildings < ActiveRecord::Base
  attr_accessible :name, as: :admin
  attr_accessible :name

  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
end
