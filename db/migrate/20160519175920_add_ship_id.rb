class AddShipId < ActiveRecord::Migration
  def change
    add_column :crew_members, :ship_id, :integer
  end
end
