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



  def add_friend(friend)
    if !friends.include?(friend)
      friends << friend
      friend.friends << self
    end
  end

def gravatar_url
   hash = Digest::MD5.hexdigest(email)
   "http://www.gravatar.com/avatar/#{hash}?d=retro&s=150 (3KB)"
 end
  
end

