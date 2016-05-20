#require 'csv'
#crew_member = CSV.read('crew_member.csv')

class CrewMember < ActiveRecord::Base
  
  belongs_to :ship

  has_many :crew_voyages
  has_many :voyages, through: :crew_voyages
  has_and_belongs_to_many :friends, class_name: "CrewMember", 
                join_table: "friends", 
                association_foreign_key: "friend_id"


  def add_friend(friend)
    if !friends.include?(friend)
      friends << friend
      friend.friends << self
    end
  end

  def list_of_friends(crew_members)
    friend_list = []
    crew_members.each do |crew_member|
    friend_list << crew_member if self.friends.include?(crew_member)
    friend_list
  end
  end

  
end

