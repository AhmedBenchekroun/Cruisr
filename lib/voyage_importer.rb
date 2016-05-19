class VoyageImporter

def initialize(filename=File.absolute_path('db/data/voyage.csv'))
    @filename = filename
  end

  def import
    field_names = ['start_date','end_date','start_port_id','end_port_id','ship_id']
    puts "Importing voyage from '#{@filename}'"
    failure_count = 0
    Voyage.transaction do
      File.open(@filename).each do |line|
        data = line.chomp.split(',')
        attribute_hash = Hash[field_names.zip(data)]
        begin
          Voyage.create!(attribute_hash)
          print '.'
        rescue ActiveRecord::UnknownAttributeError
          failure_count += 1
          print '!'
        ensure
          STDOUT.flush
        end
      end
    end
    failures = failure_count > 0 ? "(failed to create #{failure_count} Voyage records)" : ''
    puts "\nDONE #{failures}\n\n"
  end

end