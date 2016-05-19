class ShipImporter

def initialize(filename=File.absolute_path('db/data/ship.csv'))
    @filename = filename
  end

  def import
    field_names = ['name', 'company']
    puts "Importing ship from '#{@filename}'"
    failure_count = 0
    Ship.transaction do
      File.open(@filename).each do |line|
        data = line.chomp.split(',')
        attribute_hash = Hash[field_names.zip(data)]
        begin
          Ship.create!(attribute_hash)
          print '.'
        rescue ActiveRecord::UnknownAttributeError
          failure_count += 1
          print '!'
        ensure
          STDOUT.flush
        end
      end
    end
    failures = failure_count > 0 ? "(failed to create #{failure_count} Ship records)" : ''
    puts "\nDONE #{failures}\n\n"
  end

end