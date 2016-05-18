class CrewMember < ActiveRecord::Base
  
  has_many :crew_voyages
  has_many :voyages, through: :crew_voyages
  has_and_belongs_to_many :friends, class_name: "CrewMember", 
                join_table: "friends", 
                association_foreign_key: "friend_id"


  def add_friend(friend)
    friends << friend
    friend.friends << self
  end

end

