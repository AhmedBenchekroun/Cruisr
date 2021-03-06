class CrewMemberImporter

def initialize(filename=File.absolute_path('db/data/crew_member.csv'))
    @filename = filename
  end

  def import
    field_names = ['full_name', 'nationality', 'date_of_birth','email', 'password_digest']
    puts "Importing crew member from '#{@filename}'"
    failure_count = 0
    CrewMember.transaction do
      File.open(@filename).each do |line|
        data = line.chomp.split(',')
        attribute_hash = Hash[field_names.zip(data)]
        begin
          CrewMember.create!(attribute_hash)
          print '.'
        rescue ActiveRecord::UnknownAttributeError
          failure_count += 1
          print '!'
        ensure
          STDOUT.flush
        end
      end
    end
    failures = failure_count > 0 ? "(failed to create #{failure_count} CrewMember records)" : ''
    puts "\nDONE #{failures}\n\n"
    generate_friends
  end

  def generate_friends
    puts "Friendster"

    crew_members = CrewMember.all

    crew_members.each do |crew|
      #nb_friends = 1 + rand(crew_members.length)
      
      nb_friends = 1 + rand(3)
      #friend = 1 + rand(crew_members.length)
      (1..nb_friends).each do |friend_id|
        crew.add_friend(CrewMember.find(friend_id)) unless crew == CrewMember.find(friend_id)
      end
      
    end


  end

end