class DeleteShipId < ActiveRecord::Migration
  def change
    remove_column :crew_members, :ship_id, :integer
  end
end
