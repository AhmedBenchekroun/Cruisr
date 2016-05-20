class CrewVoyageImporter

  def initialize(filename=File.absolute_path('db/data/crew_voyage.csv'))
    @filename = filename
  end

  def import
    field_names = ['crew_member_id', 'voyage_id']
    puts "Importing crew voyage from '#{@filename}'"
    failure_count = 0
    CrewVoyage.transaction do
      File.open(@filename).each do |line|
        data = line.chomp.split(',')
        attribute_hash = Hash[field_names.zip(data)]
        begin
          CrewVoyage.create!(attribute_hash)
          print '.'
        rescue ActiveRecord::UnknownAttributeError
          failure_count += 1
          print '!'
        ensure
          STDOUT.flush
        end
      end
    end
    failures = failure_count > 0 ? "(failed to create #{failure_count} CrewVoyage records)" : ''
    puts "\nDONE #{failures}\n\n"
  end

  



end