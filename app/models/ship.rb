class Ship < ActiveRecord::Base

  has_many :voyages
  has_many :crew_members


end