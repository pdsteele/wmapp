class Buildings < ActiveRecord::Base
  attr_accessible :name, as: :admin

  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
end
