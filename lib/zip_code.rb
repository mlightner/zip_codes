class ZipCode

  attr_accessor :record

  ZIP_COLUMNS.each do |f|
    attr_accessor f.to_sym
  end

  def self.db
    raise "No database availablbe.  Please initialize it with Rake." unless ZIP_DB.kind_of?(SQLite3::Database)
    ZIP_DB
  end

  def db
    self.class.db
  end

  def self.columns
    ZIP_COLUMNS
  end

  def columns
    self.class.columns
  end

  def initialize(zipl)
    row = db.execute( "select * from zip_codes where zip = '#{zipl.to_s}';" ).first
    return nil unless (row.kind_of?(Array) && row[1].to_s == zipl.to_s)
    @record = {}
    columns.each_with_index do |f,i|
      @record[f.to_sym] = row[i]
      self.instance_variable_set("@#{f.to_s}".to_sym, row[i])
    end
    
  end

  def valid?
    record.kind_of?(Hash) && record.has_key?(:zip)
  end

end
