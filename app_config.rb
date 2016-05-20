require 'active_record'
require 'pry'
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
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: DATABASE_PATH
    )
  end

end
