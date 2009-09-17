require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rubygems'
require 'sqlite3'

DIR = File.dirname(__FILE__) + '/data'
system("mkdir -p #{DIR}")

desc 'Test the library.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc "Update gem files list"
task :gemfiles do
  file_name = "zip_codes.gemspec"
  files = `find ./ | grep -v \.git`.each_line.collect { |f| f.strip }.reject { |e| e =~ /^[^\W]*$$/  }
  files.shift
  file = File.new(file_name)
  lines = file.readlines
  file.close

  newf = []
  lines.each do |line|
    if line =~ /^\s+s\.files\s*\=/
      newf.push "  s.files = [\"#{files.join('","')}\"]\n"
    else
      newf.push(line.rstrip + "\n")
    end
  end

  # Don't write the file if there are no changes
  file = File.new(file_name,'w')
  newf.each do |line|
    file.write(line)
  end
  file.close
end

namespace :zip_codes do

  desc "Reloads and refreshes db and data"
  task :all => [ :clean, :download, :create_db, :load_data, :index ]

  desc 'Downloads the zip code database'
  task :download do
    require 'open-uri'
    chdir("#{DIR}")
    system("/usr/bin/env wget http://www.populardata.com/downloads/zip_codes.zip")
    system("/usr/bin/env unzip -p zip_codes.zip > zip_codes.csv")
    puts "New zip code database downloaded."
  end

  desc 'Creates the test database'
  task :create_db do
    puts "Creating zip code database..."
	  require 'csv'
	  system("rm -f #{DIR}/zip_codes.db")
	  csv = CSV.open("#{DIR}/zip_codes.csv", "r")
	  db = SQLite3::Database.new( "#{DIR}/zip_codes.db" )
	  db.execute("create table zip_codes (
	    id        INTEGER     NOT NULL PRIMARY KEY,
	    zip       VARCHAR(9)  NOT NULL,
	    zip_class       VARCHAR(9)  ,
	    city      TEXT        ,
	    county      TEXT       ,
	    state     VARCHAR(2)  ,
	    lat       FLOAT       ,
	    long      FLOAT       
	  );")

  desc "Loads zip code data"
  task :load_data
	  st = db.prepare("insert into zip_codes(zip, lat, long, city, state, county, zip_class) values(?, ?, ?, ?, ?, ?, ?)")
	  csv = CSV.open("#{DIR}/zip_codes.csv", "r")
	  csv.each_with_index do |r,i|
	    puts "Creating zip code #{r[0]} (#{i})"
	    st.execute(*r)
	  end
    puts "Database created."
  end

  desc 'Creates index on zip codes table'
  task :index do
	  db = SQLite3::Database.open( "#{DIR}/zip_codes.db" )
	  db.execute("create unique index zip_index on zip_codes (zip);") rescue nil
	  db.execute("create index zip_state_index on zip_coddes (state);") rescue nil
  end

  desc 'Cleans data dir'
  task :clean do
	  File.unlink("#{DIR}/zip_codes.csv") rescue nil
	  File.unlink("#{DIR}/zip_codes.zip") rescue nil    
  end
end


task :default => ['zip_codes:all']
