require 'csv'

class Ship < ActiveRecord::Base

  has_many :voyages


end