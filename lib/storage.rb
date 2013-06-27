class Storage
  def self.init
    db = SQLite3::Database.new($home_dir + '/sqlite')
    db.execute( %{
      CREATE TABLE foo 
      (key varchar(100) PRIMARY KEY, 
      value varchar(3000), 
      modified timestamp(20))
    } )
  end

  def self.get(key)
    db = SQLite3::Database.new($home_dir + '/sqlite')
    db.get_first_row( %{
      SELECT * FROM foo WHERE key='#{key}'
    } )
  end
  
  def self.set(key, val)
    db = SQLite3::Database.new($home_dir + '/sqlite')
    result = db.execute( %{
      REPLACE INTO foo
      (key, value, modified) 
      VALUES ('%s', '%s', %d)
    } % [key, val, Time.now.to_i] )
  end

  def self.delete(key)
    db = SQLite3::Database.new($home_dir + '/sqlite')
    result = db.execute( %{
      DELETE FROM foo
      WHERE key = %s
      } % key)
  end

  def self.getAll(key)
    db = SQLite3::Database.new($home_dir + '/sqlite')
    result = db.execute( %{
      SELECT * FROM foo WHERE key LIKE '#{key}'
      })
  end
end
