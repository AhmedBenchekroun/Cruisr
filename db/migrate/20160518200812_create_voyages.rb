class CreateVoyages < ActiveRecord::Migration
  def change
    create_table :voyages do |s|
      s.date :start_date
      s.date :end_date
      s.integer :start_port_id
      s.integer :end_port_id
      s.integer :ship_id
    end
  end
end
