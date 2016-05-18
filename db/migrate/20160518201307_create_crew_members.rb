class CreateCrewMembers < ActiveRecord::Migration
  def change
    create_table :crew_members do |s|
      s.string :full_name
      s.string :nationality
      s.date :date_of_birth
      s.string :email
    end
  end
end
