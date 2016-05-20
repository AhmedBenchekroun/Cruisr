#require 'csv'
#port = CSV.read('port.csv')

class Port < ActiveRecord::Base


def voyages
  Voyage.all.where("start_port_id = ? or end_port_id = ?", id, id)
end

end