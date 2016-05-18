class CrewVoyage < ActiveRecord::Base
  belongs_to :crew_member
  belongs_to :voyage
end