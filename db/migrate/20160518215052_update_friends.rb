class UpdateFriends < ActiveRecord::Migration
  def change
    rename_column :friends, :crew_id, :crew_member_id
  end
end
