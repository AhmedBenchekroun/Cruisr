class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |s|
      s.string :name
      s.string :company
    end
  end
end
