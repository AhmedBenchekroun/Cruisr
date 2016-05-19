#require 'csv'
#ship = CSV.read('ship.csv')

class Ship < ActiveRecord::Base

  has_many :voyages
  has_many :crew_members


end