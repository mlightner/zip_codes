#!/usr/bin/env ruby
require 'rubygems'
require 'sqlite3'

DBFILE = File.dirname(__FILE__) + '/data/zip_codes.db'
raise "Please populate the database first" unless File.exist?(DBFILE)

begin
  ZIP_DB = SQLite3::Database.open( DBFILE )
  raise "No database available.  Please initialize it with Rake." unless ZIP_DB.kind_of?(SQLite3::Database)
  ZIP_META = ZIP_DB.execute("SELECT * FROM sqlite_master;").first.last.split(/[\r\n\t]+/)
  #raise "Can't query DB" unless (ZIP_META.kind_of?(Array) && ZIP_META.include?("zip_codes"))
  ZIP_COLUMNS = []
  ZIP_META.each do |l|
    next unless l =~ /^    ([\S]+)\s+/
    ZIP_COLUMNS.push($1.to_sym)
  end
rescue Exception => e
  puts "There is a problem with your database: #{e.message}"
end

#raise ZIP_META.inspect

require File.dirname(__FILE__) + '/lib/zip_code.rb'
