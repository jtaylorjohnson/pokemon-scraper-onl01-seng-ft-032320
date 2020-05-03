class Pokemon
  
  attr_accessor :id, :name, :type, :db 
  
  def initialize (id:, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS pokemons (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
      ) 
        SQL
    
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = <<-SQL
      DROP TABLE pokemons
      SQL
    DB[:conn].execute(sql)
  end
  
  def self.save(name, type)
    sql = <<-SQL
      INSERT INTO pokemons (name, type)
      VALUES (?, ?)
      SQL
    DB[:conn].execute(sql, name, type) 
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM pokemons")[0][0]
  end
  
  def self.create(name, type)
    pokemon = Pokemon.new(name, type)
    pokemon.save
    pokemon
  end
  
  def self.new_from_db(row)
  id = row[0]
  name = row[1]
  grade = row[2]
  student = self.new(id, name, grade)
  student
  end
  
  def self.find(name)
    sql = "SELECT * FROM pokemons WHERE name = ?"
    result = DB[:conn].execute(sql, name)[0]
    self.new_from_db(result)
  end
  
  def update
    sql = "UPDATE pokemons SET name = ?, type = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.grade, self.id)
  end

end

