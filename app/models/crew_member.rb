#require 'csv'
#crew_member = CSV.read('crew_member.csv')

class CrewMember < ActiveRecord::Base
  
  belongs_to :ship

  has_many :crew_voyages
  has_many :voyages, through: :crew_voyages
  has_and_belongs_to_many :friends, class_name: "CrewMember", 
                join_table: "friends", 
                association_foreign_key: "friend_id"
  has_secure_password


  validates :full_name, presence: true
  validates :email, presence: true
  validates :date_of_birth, presence: true
  validates :nationality, presence: true

  def is_friend?(crew_member)
    friends.include?(crew_member)
  end

  def add_friend(friend)
    if !friends.include?(friend)
      friends << friend
      friend.friends << self
    end
  end

  def list_of_friends(crew_members)
    friend_list = []
    crew_members.each do |crew_member|   
    friend_list << crew_member if is_friend?(crew_member)    
    end
    friend_list
  end

  def gravatar_url
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}?d=retro&s=150"
  end

  
end

