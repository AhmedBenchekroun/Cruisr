require 'active_record'
require 'pg' if production?
#require 'pry' if development?
require 'active_support/all'
require './lib/ship_importer'
require './lib/crew_member_importer'
require './lib/port_importer'
require './lib/voyage_importer'
require './lib/crew_voyage_importer'

module AppConfig

  DATABASE = ENV['DATABASE'] || 'db'

  DATABASE_PATH = File.absolute_path("db/#{DATABASE}.sqlite3", File.dirname(__FILE__))

  def self.establish_connection
    puts "Connecting to database '#{DATABASE_PATH}'"
    
    if development? 
      ActiveRecord::Base.establish_connection(
        adapter: 'sqlite3',
        database: DATABASE_PATH
      )
    
    elsif production?
      
      ActiveRecord::Base.establish_connection(
        adapter: 'postgresql',
        database: 'postgres',
        username: 'development',
        password: 'development',
        host: 'localhost',
        port: 5432,
        pool: 5,
        encoding: 'unicode',
        min_messages: 'error'
      )
    end

puts 'CONNECTED'
  end

end
