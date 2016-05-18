class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |s|
      s.integer :crew_id
      s.integer :friend_id
    end
  end
end
