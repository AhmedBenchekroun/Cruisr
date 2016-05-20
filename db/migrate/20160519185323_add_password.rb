class AddPassword < ActiveRecord::Migration
  def change
    add_column :crew_members, :password_digest, :string
  end
end
