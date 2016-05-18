class CreatePorts < ActiveRecord::Migration
  def change
    create_table :ports do |s|
      s.string :country
      s.string :city
    end
  end
end
