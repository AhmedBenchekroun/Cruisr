class CreateCrewVoyages < ActiveRecord::Migration
  def change
    create_table :crew_voyages do |s|
      s.integer :crew_members_id
      s.integer :voyages_id
    end
  end
end
