class Voyage < ActiveRecord::Base

  belongs_to :ship
  has_many :crew_voyages
  has_many :crew_members, through: :crew_voyages
  belongs_to :start_port, class_name: "Port", foreign_key: "start_port_id"
  belongs_to :end_port, class_name: "Port", foreign_key: "end_port_id"



end