class UpdateCrewVoyage < ActiveRecord::Migration
  def change

     rename_column :crew_voyages, :crew_members_id, :crew_member_id
     rename_column :crew_voyages, :voyages_id, :voyage_id

  end
end
